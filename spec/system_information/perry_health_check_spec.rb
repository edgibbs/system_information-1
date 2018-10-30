# frozen_string_literal: true

require 'spec_helper'
require 'faraday'

module SystemInformation
  describe PerryHealthCheck do
    describe '#check' do
      let(:perry_url) { 'http://perry:8080/' }
      let(:perry_health_check) { PerryHealthCheck.new(perry_url) }

      context 'when healthy' do
        let(:response) { instance_double('Faraday::Response') }

        before do
          allow(Faraday).to receive(:get).with(perry_url).and_return(response)
          allow(response).to receive(:status).and_return(200)
        end

        it 'returns a healthy status' do
          expect(perry_health_check.check.healthy).to eq true
        end
      end

      context 'when not healthy' do
        let(:response) { instance_double('Faraday::Response') }

        before do
          allow(Faraday).to receive(:get).with(perry_url).and_return(response)
          allow(response).to receive(:status).and_return(468)
        end

        it 'returns a healthy status' do
          expect(perry_health_check.check.healthy).to eq false
        end

        it 'sets an error message' do
          expect(perry_health_check.check.message).to eq 'perry returned 468'
        end
      end

      context 'when throwing an error' do
        let(:error_message) do
          'perry returned uncaught throw ' \
           '#<Faraday::ConnectionFailed #<Faraday::ConnectionFailed: fail>>'
        end

        before do
          allow(Faraday).to receive(:get)
            .with(perry_url)
            .and_throw(Faraday::ConnectionFailed.new('fail'))
        end

        it 'returns a healthy status' do
          expect(perry_health_check.check.healthy).to eq false
        end

        it 'sets an error message' do
          expect(perry_health_check.check.message) .to eq(error_message)
        end
      end
    end
  end
end
