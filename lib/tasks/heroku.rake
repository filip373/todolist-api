# frozen_string_literal: true

namespace :heroku do
  desc 'Set application url in heroku env variable'
  task set_hostname: :environment do
    SetHerokuHostname.new.call
  end
end
