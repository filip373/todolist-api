# frozen_string_literal: true

class GetUserFromJWT
  def initialize(token)
    @token = token
  end

  def call
    raise 'Invalid token object' unless @token.is_a?(Hash)
    User.find_by oauth_id: @token['sub']
  end
end
