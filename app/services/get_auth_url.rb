# frozen_string_literal: true

class GetAuthURL
  def call
    URI::HTTPS.build(
      host: Settings.auth0_domain,
      path: '/authorize',
      query: QUERY.to_query
    ).to_s
  end

  QUERY = {
    response_type: 'code',
    client_id: Settings.auth0_client_id,
    redirect_uri: RedirectURI.new.call,
    audience: Settings.auth0_api_audience
  }.freeze
end
