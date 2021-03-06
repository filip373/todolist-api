# frozen_string_literal: true

class GetAccessToken
  def initialize(code)
    @code = code
  end

  def call
    payload = response_payload
    access_token = payload['access_token']
    raise GetTokenError, payload if payload['error'] || !access_token
    payload['access_token']
  end

  URL = URI::HTTPS.build(host: Settings.auth0.domain).to_s

  DEFAULT_BODY = {
    grant_type: 'authorization_code',
    client_id: Settings.auth0.client_id,
    client_secret: Settings.auth0.client_secret,
    redirect_uri: RedirectURI.new.call
  }.freeze

  private

  def response_payload
    JSON.parse response.body
  end

  def response
    Faraday.new(url: URL).post do |req|
      req.url '/oauth/token'
      req.headers['Content-Type'] = 'application/json'
      req.body = body.to_json
    end
  end

  def body
    DEFAULT_BODY.merge code: @code
  end
end
