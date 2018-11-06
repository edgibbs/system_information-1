# frozen_string_literal: true

module SystemInformation
  module ValidHealthCheckNames
    def valid_health_check_names
      {
        redis: RedisHealthCheck,
        perry: PerryHealthCheck,
        ferb_api: FerbApiHealthCheck,
        dora_api: DoraApiHealthCheck
      }
    end
  end
end
