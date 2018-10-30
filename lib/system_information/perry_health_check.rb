# frozen_string_literal: true

module SystemInformation
  class PerryHealthCheck
    include HealthCheckErrors

    def initialize(url = 'http://localhost:8080')
      @perry_url = url
    end

    def check
      item = HealthCheckItem.new(:perry, true)
      begin
        response = Faraday.get @perry_url
        set_error_status(item, response.status) unless response.status == 200
      rescue StandardError => error
        set_error_status(item, error.message)
      end
      item
    end
  end
end
