# frozen_string_literal: true

require 'redis'

module SystemInformation
  class HealthChecker
    def check
      health_checks = []
      SystemInformation.checks.each do |check|
        health_checks << checker_class(check[:name]).new(check[:url]).check
      end
      health_check_message = HealthCheckMessage.new(overall_health(health_checks), health_checks)
      [health_check_message.status_code, health_check_message.to_json]
    end

    private

    def overall_health(health_checks)
      health_checks.map(&:healthy).reduce(:&)
    end

    def checker_class(name)
      checks[name]
    end

    def checks
      {
        redis: RedisHealthCheck
      }
    end

    # def redis_check
    #   item = HealthCheckItem.new(:redis, true)
    #   begin
    #     @redis.ping
    #   rescue StandardError => error
    #     set_error_status(item, error.message)
    #   end
    #   item
    # end

    # def set_error_status(item, message)
    #   item.healthy = false
    #   item.message = "#{item.name} returned #{message}"
    # end
  end
end
