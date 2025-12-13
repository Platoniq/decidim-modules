ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require "bundler/setup" # Set up gems listed in the Gemfile.
require "bootsnap/setup" # Speed up boot time by caching expensive operations.

# Configure Redis URL before Rails loads
if ENV['REDIS_URL']
  # Set all possible Redis environment variables
  ENV['CABLE_URL'] ||= ENV['REDIS_URL']
  ENV['REDIS_CACHE_URL'] ||= ENV['REDIS_URL']
  ENV['REDIS_SESSION_URL'] ||= ENV['REDIS_URL']
  ENV['SIDEKIQ_REDIS_URL'] ||= ENV['REDIS_URL']
  
  # Monkey-patch Redis.new to use REDIS_URL by default
  require 'redis'
  Redis.class_eval do
    class << self
      alias_method :original_new, :new
      
      def new(options = {})
        if options.is_a?(Hash) && !options[:url]
          options[:url] = ENV['REDIS_URL']
        end
        original_new(options)
      end
    end
  end
end