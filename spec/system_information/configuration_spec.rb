# frozen_string_literal: true

require 'spec_helper'

module SystemInformation
  describe Configuration do
    describe '#checks' do
      context 'with just defaults set' do
        it 'returns an empty array' do
          SystemInformation.configure { |config| }
          expect(SystemInformation.configuration.checks).to eq []
        end
      end
    end
  end
end
