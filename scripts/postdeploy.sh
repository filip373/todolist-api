#!/bin/sh

bundle exec rails db:schema:load db:seed
heroku config:set APP_URL=https://${HEROKU_APP_NAME}.herokuapp.com --app ${HEROKU_APP_NAME}"
