# frozen_string_literal: true

require_relative "boot"

require "decidim/rails"

# Add the frameworks used by your app that are not loaded by Decidim.
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_cable/engine"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DecidimModules
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configure Redis for production
    if Rails.env.production?
      redis_url = ENV.fetch("REDIS_URL", "redis://localhost:6379/0")
      
      # Configure cache store
      config.cache_store = :redis_cache_store, {
        url: redis_url,
        connect_timeout: 5,
        reconnect_attempts: 3,
        error_handler: -> (method:, returning:, exception:) {
          Rails.logger.warn("Redis error: #{exception.message}") if defined?(Rails.logger)
        }
      }
    end

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end