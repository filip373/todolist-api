web: bundle exec puma -p $PORT
worker: bundle exec sidekiq -c 5 -v -q default -q mailers
release: bundle exec rails db:migrate
