# frozen_string_literal: true

require 'spec_helper'
require 'json'
require 'rack'

module SystemInformation
  describe SystemInformationMiddleware do
    describe '#call' do
      let(:application) { ->(environment) { [200, environment, 'application'] } }
      let(:middleware) { SystemInformationMiddleware.new(application) }

      context 'when /system-information' do
        let(:health_checker) { instance_double('SystemInformation::HealthChecker') }
        let(:health_check_response) { [200, { application: 'CANS' }.to_json] }
        let(:environment) do
          Rack::MockRequest.env_for('http://example.com/cans/system-information', {})
        end

        before do
          allow(HealthChecker).to receive(:new).and_return(health_checker)
          allow(health_checker).to receive(:check).and_return(health_check_response)
        end

        it 'returns status code' do
          status, _headers, _body = middleware.call(environment)
          expect(status).to eq 200
        end

        it 'returns an application/javascript header' do
          _status, headers, _body = middleware.call(environment)
          expect(headers).to eq 'Content-Type' => 'application/json'
        end

        it 'returns a json payload' do
          _status, _headers, body = middleware.call(environment)
          expect(body).to eq([{ application: 'CANS' }.to_json])
        end
      end

      context 'when not /system-information' do
        let(:environment) do
          Rack::MockRequest.env_for('http://example.com/cans/fetch_stuff', {})
        end

        it 'passes along the request unchanged' do
          expect(application).to receive(:call).with(environment)
          middleware.call(environment)
        end
      end
    end
  end
end
