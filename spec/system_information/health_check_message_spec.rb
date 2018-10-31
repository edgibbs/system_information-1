# frozen_string_literal: true

require 'spec_helper'
require 'json'

module SystemInformation
  describe HealthCheckMessage do
    let(:health_check_message) { HealthCheckMessage.new(true, []) }
    let(:configuration) do
      config = Configuration.new
      config.application = 'Example App'
      config.version = '7.7.7'
      config
    end

    before do
      allow(SystemInformation).to receive(:configation).and_return(configuration)
    end

    describe '#attribute' do
      it 'has an application name' do
        expect(health_check_message.application).to eq ''
      end

      it 'has a version' do
        expect(health_check_message.version).to eq ''
      end

      it 'has a health status' do
        expect(health_check_message.health_status).to eq true
      end

      it 'has health_checks' do
        expect(health_check_message.health_checks).to eq []
      end
    end

    describe '#status_code' do
      context 'when health status is true' do
        it 'returns 200' do
          expect(HealthCheckMessage.new(true, []).status_code).to eq 200
        end
      end

      context 'when health status is false' do
        it 'returns 465' do
          expect(HealthCheckMessage.new(false, []).status_code).to eq 465
        end
      end
    end

    describe '#to_json' do
      let(:timestamp) { Time.now }
      let(:health_checks) { [HealthCheckItem.new(:redis, true, timestamp)] }
      let(:health_check_message) { HealthCheckMessage.new(true, health_checks) }
      let(:expected_json) do
        {
          application: '',
          version: '',
          health_status: true,
          health_checks: {
            redis: {
              healthy: true,
              message: '',
              timestamp: timestamp
            }
          }
        }.to_json
      end

      it 'returns a valid json object' do
        expect(health_check_message.to_json).to eq(expected_json)
      end
    end
  end
end
