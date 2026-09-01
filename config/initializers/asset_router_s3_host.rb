# frozen_string_literal: true

# Decidim::AssetRouter::Storage forwards the caller's :host straight into
# ActiveStorage, both from #blob_url and from #variant_url, and the S3 service
# passes it on to the AWS presigner as an operation parameter. The presigner
# rejects it with "unexpected value at params[:host]", returning a 500 for
# every page that renders the asset.
#
# It only shows up when the storage service is S3 and no storage.cdn_host is
# configured, because that is the one combination where blob_url reaches
# Blob#url instead of a route helper. The favicon helpers in
# Decidim::LayoutHelper are the only callers that pass :host, so setting an
# organization favicon takes the whole site down.
#
# The failure is delayed: #variant_url only reaches ActiveStorage once
# asset.processed? is true, and until then it returns nil and the caller falls
# back to a route helper. Requesting /favicon.ico is what processes the ICO
# variant, so the site stays healthy until something asks for it.
Rails.application.config.to_prepare do
  Decidim::AssetRouter::Storage.prepend(Module.new do
    private

    def blob_url(**options)
      return super unless blob
      return super if options[:only_path] || remote? || !asset_url_available?

      super(**options.except(:host, :protocol, :port))
    end

    def variant_url(**options)
      super(**options.except(:host, :protocol, :port))
    end
  end)
end
