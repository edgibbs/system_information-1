# frozen_string_literal: true

require 'spec_helper'
require 'redis'
require 'json'

module SystemInformation
  describe HealthChecker do
    describe '#check' do
      let(:health_checker) { HealthChecker.new }
      let(:redis_health_check) { instance_double('SystemInformation::RedisHealthCheck') }
      let(:checks) { [{ name: :redis, url: 'redis://localhost:6379' }] }
      let(:configuration) do
        config = Configuration.new
        config.application = 'Example App'
        config.version = '4.2'
        config.checks = checks
        config
      end

      before do
        allow(SystemInformation).to receive(:configuration).and_return(configuration)
      end

      context 'when all services are up' do
        before do
          allow(RedisHealthCheck).to receive(:new)
            .with('redis://localhost:6379')
            .and_return(redis_health_check)
          allow(redis_health_check).to receive(:check)
            .with(no_args)
            .and_return(HealthCheckItem.new(:redis, true))
        end

        it 'returns a 200 status code' do
          status, _response = health_checker.check
          expect(status).to eq 200
        end

        it 'shows as healthy' do
          _status, response = health_checker.check
          expect(JSON.parse(response)['health_status']).to eq true
        end

        it 'returns redis success' do
          _status, response = health_checker.check
          expect(JSON.parse(response)['health_checks']['redis']['healthy']).to eq true
        end
      end

      context 'when no checks are configured' do
        let(:checks) { [] }

        it 'returns a 465 status' do
          status, _response = health_checker.check
          expect(status).to eq 465
        end

        it 'shows as not healthy' do
          _status, response = health_checker.check
          expect(JSON.parse(response)['health_status']).to eq false
        end

        it 'has no health checks' do
          _status, response = health_checker.check
          expect(JSON.parse(response)['health_checks']).to eq({})
        end
      end

      context 'when redis is down' do
        before do
          allow(RedisHealthCheck).to receive(:new)
            .with('redis://localhost:6379')
            .and_return(redis_health_check)
          allow(redis_health_check).to receive(:check)
            .with(no_args)
            .and_return(HealthCheckItem.new(:redis, false, Time.now, 'Redis::CannotConnectError'))
        end

        it'returns a 465 status code' do
          status, _response = health_checker.check
          expect(status).to eq 465
        end

        it 'shows as not healthy' do
          _status, response = health_checker.check
          expect(JSON.parse(response)['health_status']).to eq false
        end

        it 'returns redis failure' do
          _status, response = health_checker.check
          expect(JSON.parse(response)['health_checks']['redis']['healthy']).to eq false
        end

        it 'returns error message' do
          _status, response = health_checker.check
          message = JSON.parse(response)['health_checks']['redis']['message']
          expect(message).to match('Redis::CannotConnectError')
        end
      end
    end
  end
end
