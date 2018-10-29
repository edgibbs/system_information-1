require 'spec_helper'

describe SystemInformation do
  let(:configuration) { SystemInformation::Configuration.new }

  after do
    SystemInformation.reset
  end

  describe ".configuration" do
    it 'has a configration' do
      SystemInformation.reset
      allow(SystemInformation::Configuration).to receive(:new).and_return(configuration)
      expect(SystemInformation.configuration).to eq configuration
    end
  end

  describe '.configure' do
    it 'yields configuration to the block' do
      allow(SystemInformation::Configuration).to receive(:new).and_return(configuration)
      expect(SystemInformation.configure { |config| config }).to eq configuration
    end
  end

  describe '.reset' do
    it 'resets the configuration' do
      expect(SystemInformation::Configuration).to receive(:new)
      SystemInformation.configuration
      SystemInformation.reset
      expect(SystemInformation.instance_variable_get(:@configuration)).to eq nil
    end
  end
end
