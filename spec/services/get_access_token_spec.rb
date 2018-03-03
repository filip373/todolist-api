# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GetAccessToken, type: :service do
  subject { described_class.new(code) }

  describe '#call' do
    context 'when code is valid' do
      let(:code) { JWTHelper.valid_code }

      it 'returns access token' do
        VCR.use_cassette(
          'get_token_valid_code', match_requests_on: [:body_as_json]
        ) do
          expect(subject.call).to eq(JWTHelper.valid_jwt)
        end
      end
    end

    context 'when code is NOT valid' do
      let(:code) { 'asdf' }

      it 'raises error' do
        VCR.use_cassette(
          'get_token_invalid_code', match_requests_on: [:body_as_json]
        ) do
          expect { subject.call }.to raise_error(GetTokenError)
        end
      end
    end
  end
end
