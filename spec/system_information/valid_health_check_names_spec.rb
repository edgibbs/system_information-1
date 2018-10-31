# frozen_string_literal: true

require 'spec_helper'

module SystemInformation
  class ValidHealthCheckNamesTest
    include ValidHealthCheckNames
  end

  describe ValidHealthCheckNames do
    describe '#valid_health_check_names' do
      let(:valid_health_check_names_test) { ValidHealthCheckNamesTest.new }
      let(:checks) { valid_health_check_names_test.valid_health_check_names }

      it 'has two valid checks' do
        expect(checks.keys).to eq %i[redis perry]
        expect(checks.values).to eq [RedisHealthCheck, PerryHealthCheck]
      end
    end
  end
end
