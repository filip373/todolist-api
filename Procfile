web: bundle exec puma -p $PORT
worker: bundle exec sidekiq -c 5 -v
release: bundle exec rails db:migrate
