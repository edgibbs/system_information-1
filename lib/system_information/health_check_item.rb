# frozen_string_literal: true

module SystemInformation
  class HealthCheckItem
    attr_reader :name
    attr_accessor :healthy
    attr_reader :timestamp
    attr_accessor :message

    def initialize(name, healthy, timestamp = Time.now, message = '')
      @name = name
      @healthy = healthy
      @message = message
      @timestamp = timestamp
    end

    def values
      {
        healthy: healthy,
        message: message,
        timestamp: timestamp
      }
    end
  end
end
