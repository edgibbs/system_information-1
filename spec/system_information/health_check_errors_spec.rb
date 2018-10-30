# frozen_string_literal: true

require 'spec_helper'

module SystemInformation
  class HealthCheckErrorsTest
    include HealthCheckErrors
  end

  describe HealthCheckErrors do
    describe '#set_error_status' do
      let(:health_check_item) { HealthCheckItem.new(:redis, true) }
      let(:health_check_errors_test) { HealthCheckErrorsTest.new }

      it 'sets item status to healthy' do
        health_check_errors_test.set_error_status(health_check_item, 'badness')
        expect(health_check_item.healthy).to eq false
      end

      it 'sets message' do
        health_check_errors_test.set_error_status(health_check_item, 'badness')
        expect(health_check_item.message).to eq 'redis returned badness'
      end
    end
  end
end
