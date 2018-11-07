# frozen_string_literal: true

module SystemInformation
  class CalsApiHealthCheck
    include HealthCheckErrors

    def initialize(url = 'http://localhost:8080')
      @calsapi_url = url
    end

    def check
      item = HealthCheckItem.new(:cals_api, true)
      begin
        response = Faraday.get @calsapi_url
        set_error_status(item, response.status) unless response.status == 200
      rescue StandardError => error
        set_error_status(item, error.message)
      end
      item
    end
  end
end
