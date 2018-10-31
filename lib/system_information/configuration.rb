# frozen_string_literal: true

module SystemInformation
  class Configuration
    attr_accessor :checks
    attr_accessor :application
    attr_accessor :version

    def initialize
      @checks = []
      @application = ''
      @version = ''
    end
  end
end
