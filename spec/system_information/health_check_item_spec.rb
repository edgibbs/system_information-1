# frozen_string_literal: true

require 'spec_helper'
require 'timecop'

module SystemInformation
  describe HealthCheckItem do
    describe '#initialize' do
      context 'when passing all arguments' do
        it 'sets initial state' do
          Timecop.freeze(Time.now) do
            item = HealthCheckItem.new(:redis, false, Time.now, 'is up')
            expect(item.name).to eq :redis
            expect(item.healthy).to eq false
            expect(item.message).to eq 'is up'
            expect(item.timestamp).to eq Time.now
          end
        end
      end

      context 'when passing minimal arguments' do
        it 'sets timestamp and message to defaults' do
          Timecop.freeze(Time.now) do
            item = HealthCheckItem.new(:redis, true)
            expect(item.message).to eq ''
            expect(item.timestamp).to eq Time.now
          end
        end
      end
    end

    describe '#values' do
      it 'returns health status, message and timestamp' do
        Timecop.freeze(Time.now) do
          item = HealthCheckItem.new(:redis, true)
          expect(item.values).to eq healthy: true, message: '', timestamp: Time.now
        end
      end
    end
  end
end
