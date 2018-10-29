# frozen_string_literal: true

module SystemInformation
  class Configuration
    attr_accessor :checks
    def initialize
      @checks = []
    end
  end
end
