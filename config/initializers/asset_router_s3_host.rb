# frozen_string_literal: true

# Decidim::AssetRouter::Storage#blob_url forwards the caller's :host straight
# into ActiveStorage::Blob#url, which the S3 service passes on to the AWS
# presigner as an operation parameter. The presigner rejects it with
# "unexpected value at params[:host]", returning a 500 for every page that
# renders the asset.
#
# It only shows up when the storage service is S3 and no storage.cdn_host is
# configured, because that is the one combination where blob_url reaches
# Blob#url instead of a route helper. The favicon helpers in
# Decidim::LayoutHelper are the only callers that pass :host, so setting an
# organization favicon takes the whole site down once /favicon.ico has been
# requested and the ICO variant resolves to the attachment itself.
Rails.application.config.to_prepare do
  Decidim::AssetRouter::Storage.prepend(Module.new do
    private

    def blob_url(**options)
      return super unless blob
      return super if options[:only_path] || remote? || !asset_url_available?

      super(**options.except(:host, :protocol, :port))
    end
  end)
end
