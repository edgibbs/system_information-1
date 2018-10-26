require "system_information/configuration"
require "system_information/health_check_item"
require "system_information/health_check_message"
require "system_information/version"

module SystemInformation
  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  def self.reset
    @configuration = nil
  end
end
