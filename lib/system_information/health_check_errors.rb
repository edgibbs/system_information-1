# frozen_string_literal: true

module SystemInformation
  module HealthCheckErrors
    def set_error_status(item, message)
      item.healthy = false
      item.message = "#{item.name} returned #{message}"
    end
  end
end
