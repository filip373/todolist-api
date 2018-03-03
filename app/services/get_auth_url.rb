# frozen_string_literal: true

class GetAuthURL
  def call
    URI::HTTPS.build(
      host: Settings.auth0.domain,
      path: '/authorize',
      query: QUERY.to_query
    ).to_s
  end

  QUERY = {
    response_type: 'code',
    client_id: Settings.auth0.client_id,
    redirect_uri: RedirectURI.new.call,
    audience: Settings.auth0.api_audience
  }.freeze
end
