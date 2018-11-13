# frozen_string_literal: true

require 'system_information/health_check_errors'
require 'system_information/valid_health_check_names'
require 'system_information/configuration'
require 'system_information/cals_api_health_check'
require 'system_information/cans_api_health_check.rb'
require 'system_information/dora_api_health_check'
require 'system_information/ferb_api_health_check'
require 'system_information/geo_api_health_check'
require 'system_information/health_checker'
require 'system_information/health_check_item'
require 'system_information/health_check_message'
require 'system_information/perry_health_check'
require 'system_information/redis_health_check'
require 'system_information/system_information_middleware'
require 'system_information/version'

module SystemInformation
  # rubocop:disable Lint/DuplicateMethods
  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end
  # rubocop:enable Lint/DuplicateMethods

  def self.configure
    yield(configuration)
  end

  def self.reset
    @configuration = nil
  end
end
