# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GetAuthURL, type: :service do
  subject { described_class.new }

  describe '#call' do
    it 'returns valid https URL' do
      expect(subject.call)
        .to match(/\A#{URI::DEFAULT_PARSER.make_regexp('https')}\z/)
    end

    it 'returns URL within auth0 domain' do
      expect(subject.call)
        .to match(%r{\Ahttps://todolist-test\.eu\.auth0\.com})
    end
  end
end
