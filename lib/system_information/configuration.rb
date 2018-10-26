module SystemInformation
  class Configuration
    attr_accessor :checks
    def initialize
      @checks = []
    end
  end
end
