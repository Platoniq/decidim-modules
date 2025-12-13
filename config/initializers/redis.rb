# config/initializers/redis.rb
# Configure Redis for cache and sessions

if Rails.env.production?
  redis_url = ENV.fetch("REDIS_URL", "redis://localhost:6379/0")
  
  # Configure cache store
  Rails.application.config.cache_store = :redis_cache_store, {
    url: redis_url,
    connect_timeout: 5,
    reconnect_attempts: 3,
    error_handler: -> (method:, returning:, exception:) {
      Rails.logger.warn("Redis cache error in #{method}: #{exception.message}")
    }
  }
end
