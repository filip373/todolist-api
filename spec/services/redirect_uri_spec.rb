# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RedirectURI, type: :service do
  subject { described_class.new }

  describe '#call' do
    it 'returns valid redirect URI' do
      expect(subject.call).to eq('http://todolist.test/auth/callback')
    end
  end
end
