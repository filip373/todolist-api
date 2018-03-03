# frozen_string_literal: true

class RedirectURI
  VALUE = Settings.hostname + '/auth/callback'

  def call
    VALUE
  end
end
