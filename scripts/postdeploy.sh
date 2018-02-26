#!/bin/sh

bundle exec rails db:schema:load db:seed
export APP_URL=https://$HEROKU_APP_NAME.herokuapp.com
