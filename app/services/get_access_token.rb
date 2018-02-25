# frozen_string_literal: true

class GetAccessToken
  def initialize(code)
    @code = code
  end

  def call
    response_payload = get_response_payload
    access_token = response_payload['access_token']
    if response_payload['error'] || !access_token
      raise GetTokenError, response_payload
    end
    response_payload['access_token']
  end

  URL = URI::HTTPS.build(host: Settings.auth0_domain).to_s

  DEFAULT_BODY = {
    grant_type: 'authorization_code',
    client_id: Settings.auth0_client_id,
    client_secret: Settings.auth0_client_secret,
    redirect_uri: RedirectURI.new.call
  }.freeze

  private

  def get_response_payload
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
