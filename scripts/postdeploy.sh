#!/bin/sh

export APP_URL=https://$HEROKU_APP_NAME.herokuapp.com
bundle exec rails db:schema:load db:seed
