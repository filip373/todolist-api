# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SetHerokuHostname, type: :service do
  subject { described_class.new }

  describe '#call' do
    before do
      allow(Settings).to receive(:reload!)
      allow(PlatformAPI).to receive(:connect_oauth).and_return(platform_api)
      allow(platform_api).to receive(:config_var).and_return(config_var)
      allow(config_var).to receive(:update)
    end
    let(:platform_api) { double }
    let(:config_var) { double }

    it 'connects to platform API' do
      expect(PlatformAPI).to receive(:connect_oauth).with('test-token')
      subject.call
    end

    it 'sets config var with correct hostname' do
      expect(config_var).to receive(:update).with(
        'test-app', 'HOSTNAME' => 'https://test-app.herokuapp.com'
      )
      subject.call
    end

    it 'reloads config settings' do
      expect(Settings).to receive(:reload!)
      subject.call
    end
  end
end
