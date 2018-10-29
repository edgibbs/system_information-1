# frozen_string_literal: true

require 'system_information/configuration'
require 'system_information/health_check_item'
require 'system_information/health_check_message'
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
