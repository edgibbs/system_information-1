# frozen_string_literal: true

module SystemInformation
  class RedisHealthCheck
    include HealthCheckErrors

    def initialize(redis = Redis.new(url: 'redis://localhost:6379'))
      @redis = redis
    end

    def check
      item = HealthCheckItem.new(:redis, true)
      begin
        @redis.ping
      rescue StandardError => error
        set_error_status(item, error.message)
      end
      item
    end
  end
end
