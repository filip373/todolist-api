# frozen_string_literal: true

class DecodeJWT
  def initialize(raw_jwt)
    @raw_jwt = raw_jwt
  end

  def call
    raise DecodeJWTError, 'JWT cannot be nil' unless @raw_jwt
    JSON::JWT.decode @raw_jwt, jwks
  rescue JSON::JWT::InvalidFormat,
         JSON::JWT::VerificationFailed,
         JSON::JWT::UnexpectedAlgorithm
    raise DecodeJWTError, 'Invalid JWT value'
  end

  private

  def jwks
    JSON::JWK::Set.new parsed_jwks
  end

  def parsed_jwks
    JSON.parse fetch_jwks.body
  end

  def fetch_jwks
    Faraday.get jwks_url
  end

  def jwks_url
    URI::HTTPS.build(
      host: Settings.auth0.domain,
      path: '/.well-known/jwks.json'
    ).to_s
  end
end
