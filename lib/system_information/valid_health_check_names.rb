# frozen_string_literal: true

module SystemInformation
  module ValidHealthCheckNames
    def valid_health_check_names
      {
        redis: RedisHealthCheck,
        perry: PerryHealthCheck,
        ferbapi: FerbApiHealthCheck,
        doraapi: DoraApiHealthCheck
      }
    end
  end
end
