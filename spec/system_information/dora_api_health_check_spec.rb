# frozen_string_literal: true

require 'spec_helper'
require 'faraday'

module SystemInformation
  describe DoraApiHealthCheck do
    describe '#check' do
      let(:doraapi_url) { 'http://doraapi:8080/' }
      let(:dora_api_health_check) { DoraApiHealthCheck.new(doraapi_url) }

      context 'when healthy' do
        let(:response) { instance_double('Faraday::Response') }

        before do
          allow(Faraday).to receive(:get).with(doraapi_url).and_return(response)
          allow(response).to receive(:status).and_return(200)
        end

        it 'returns a healthy status' do
          expect(dora_api_health_check.check.healthy).to eq true
        end
      end

      context 'when not healthy' do
        let(:response) { instance_double('Faraday::Response') }

        before do
          allow(Faraday).to receive(:get).with(doraapi_url).and_return(response)
          allow(response).to receive(:status).and_return(468)
        end

        it 'returns a healthy status' do
          expect(dora_api_health_check.check.healthy).to eq false
        end

        it 'sets an error message' do
          expect(dora_api_health_check.check.message).to eq 'dora_api returned 468'
        end
      end

      context 'when throwing an error' do
        let(:error_message) do
          'dora_api returned uncaught throw ' \
           '#<Faraday::ConnectionFailed #<Faraday::ConnectionFailed: fail>>'
        end

        before do
          allow(Faraday).to receive(:get)
            .with(doraapi_url)
            .and_throw(Faraday::ConnectionFailed.new('fail'))
        end

        it 'returns a healthy status' do
          expect(dora_api_health_check.check.healthy).to eq false
        end

        it 'sets an error message' do
          expect(dora_api_health_check.check.message) .to eq(error_message)
        end
      end
    end
  end
end
