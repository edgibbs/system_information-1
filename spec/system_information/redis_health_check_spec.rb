# frozen_string_literal: true

require 'spec_helper'

module SystemInformation
  describe RedisHealthCheck do
    describe '#check' do
      let(:redis) { instance_double('Redis') }
      let(:redis_health_check) { RedisHealthCheck.new(redis) }

      context 'when healthy' do
        before do
          allow(redis).to receive(:ping).with(no_args).and_return("PONG")
        end

        it 'returns a healthy status' do
          expect(redis_health_check.check.healthy).to eq true
        end

        it 'does not set a message' do
          expect(redis_health_check.check.message).to eq ''
        end
      end

      context 'when redis is down' do
        before do
          allow(redis).to receive(:ping).with(no_args).and_throw(Redis::CannotConnectError.new)
        end

        it 'returns a healthy status' do
          expect(redis_health_check.check.healthy).to eq false
        end

        it 'sets an error message' do
          expect(redis_health_check.check.message).to eq 'redis returned uncaught throw #<Redis::CannotConnectError: Redis::CannotConnectError>'
        end
      end
    end
  end
end
