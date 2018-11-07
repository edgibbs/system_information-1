# frozen_string_literal: true

module SystemInformation
  module ValidHealthCheckNames
    def valid_health_check_names
      {
        redis: RedisHealthCheck,
        perry: PerryHealthCheck,
        cals_api: CalsApiHealthCheck,
        dora_api: DoraApiHealthCheck,
        ferb_api: FerbApiHealthCheck
      }
    end
  end
end
