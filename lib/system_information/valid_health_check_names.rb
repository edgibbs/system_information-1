# frozen_string_literal: true

module SystemInformation
  module ValidHealthCheckNames
    def valid_health_check_names
      {
        redis: RedisHealthCheck,
        perry: PerryHealthCheck,
        cals_api: CalsApiHealthCheck,
        cans_api: CansApiHealthCheck,
        dora_api: DoraApiHealthCheck,
        ferb_api: FerbApiHealthCheck,
        geo_api: GeoApiHealthCheck
      }
    end
  end
end
