# frozen_string_literal: true

class SetHerokuHostname
  def call
    heroku = PlatformAPI.connect_oauth Settings.heroku.api_token
    heroku.config_var.update Settings.heroku.app_name, 'HOSTNAME' => hostname
    Settings.reload!
  end

  private

  def hostname
    "https://#{Settings.heroku.app_name}.herokuapp.com"
  end
end
