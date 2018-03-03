#!/bin/sh

bundle exec rails heroku:set_hostname db:schema:load db:seed
