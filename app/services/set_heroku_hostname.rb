# frozen_string_literal: true

class SetHerokuHostname
  def call
    heroku = PlatformAPI.connect_oauth Settings.heroku_api_token
    heroku.config_var.update Settings.heroku_app_name, 'HOSTNAME' => hostname
    Settings.reload!
  end

  private

  def hostname
    "https://#{Settings.heroku_app_name}.herokuapp.com"
  end
end
