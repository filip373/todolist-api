# frozen_string_literal: true

class RedirectURI
  VALUE = Settings.app_url + '/auth/callback'

  def call
    VALUE
  end
end
