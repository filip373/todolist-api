# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DecodeJWT, type: :service do
  subject { described_class.new(raw_jwt) }

  describe '#call' do
    context 'when given JWT is nil' do
      let(:raw_jwt) { nil }

      it 'raises DecodeJWTError' do
        expect { subject.call }.to raise_error(DecodeJWTError)
      end

      it 'raises error about nil token' do
        expect { subject.call }.to raise_error('JWT cannot be nil')
      end
    end

    context 'when given JWT is empty' do
      let(:raw_jwt) { '' }

      it 'raises DecodeJWTError' do
        VCR.use_cassette('auth0_jwks') do
          expect { subject.call }.to raise_error(DecodeJWTError)
        end
      end
    end

    context 'when given JWT signature does NOT match public key' do
      let(:raw_jwt) { JWTHelper.invalid_jwt }

      it 'raises DecodeJWTError' do
        VCR.use_cassette('auth0_jwks') do
          expect { subject.call }.to raise_error(DecodeJWTError)
        end
      end
    end

    context 'when given JWT signature matches public key' do
      let(:raw_jwt) { JWTHelper.valid_jwt }

      it 'returns kind of Hash' do
        VCR.use_cassette('auth0_jwks') do
          expect(subject.call).to be_kind_of(Hash)
        end
      end

      it 'contains standard JWT elements', :aggregate_failures do
        VCR.use_cassette('auth0_jwks') do
          jwt = subject.call
          expect(jwt).to have_key('iss')
          expect(jwt).to have_key('sub')
          expect(jwt).to have_key('aud')
          expect(jwt).to have_key('iat')
          expect(jwt).to have_key('exp')
          expect(jwt).to have_key('azp')
        end
      end
    end
  end
end
