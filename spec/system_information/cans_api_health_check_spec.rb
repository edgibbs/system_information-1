# frozen_string_literal: true

require 'spec_helper'
require 'faraday'

module SystemInformation
  describe CansApiHealthCheck do
    describe '#check' do
      let(:cansapi_url) { 'http://cansapi:8080/' }
      let(:cans_api_health_check) { CansApiHealthCheck.new(cansapi_url) }

      context 'when healthy' do
        let(:response) { instance_double('Faraday::Response') }

        before do
          allow(Faraday).to receive(:get).with(cansapi_url).and_return(response)
          allow(response).to receive(:status).and_return(200)
        end

        it 'returns a healthy status' do
          expect(cans_api_health_check.check.healthy).to eq true
        end
      end

      context 'when not healthy' do
        let(:response) { instance_double('Faraday::Response') }

        before do
          allow(Faraday).to receive(:get).with(cansapi_url).and_return(response)
          allow(response).to receive(:status).and_return(468)
        end

        it 'returns a healthy status' do
          expect(cans_api_health_check.check.healthy).to eq false
        end

        it 'sets an error message' do
          expect(cans_api_health_check.check.message).to eq 'cans_api returned 468'
        end
      end

      context 'when throwing an error' do
        let(:error_message) do
          'cans_api returned uncaught throw ' \
           '#<Faraday::ConnectionFailed #<Faraday::ConnectionFailed: fail>>'
        end

        before do
          allow(Faraday).to receive(:get)
            .with(cansapi_url)
            .and_throw(Faraday::ConnectionFailed.new('fail'))
        end

        it 'returns a healthy status' do
          expect(cans_api_health_check.check.healthy).to eq false
        end

        it 'sets an error message' do
          expect(cans_api_health_check.check.message) .to eq(error_message)
        end
      end
    end
  end
end
