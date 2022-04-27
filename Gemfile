# frozen_string_literal: true

source 'https://rubygems.org'
# read ruby version from .ruby-version file
ruby File.read('.ruby-version').strip

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Default groups

group :config, :default do
  gem 'config'
end

group :core, :default do
  gem 'active_model_serializers', '~> 0.10.0'
  gem 'faker'
  gem 'faraday'
  gem 'json-jwt'
  gem 'rails', '~> 5.2.7'
  gem 'sidekiq'
end

group :database, :default do
  gem 'pg'
end

group :docs, :default do
  gem 'swagger_ui_engine'
end

group :server, :default do
  gem 'puma', '~> 3.7'
end

# Environment groups

group :production do
  gem 'sentry-raven'
end

group :production, :test do
  gem 'platform-api'
end

group :test do
  gem 'codeclimate-test-reporter', require: false
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'simplecov', require: false
  gem 'timecop'
  gem 'vcr'
  gem 'webmock'
end

group :development, :test do
  gem 'factory_bot_rails'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec-rails'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'brakeman', require: false
  gem 'foreman', require: false
  gem 'guard', require: false
  gem 'guard-brakeman', require: false
  gem 'guard-rspec', require: false
  gem 'guard-rubocop', require: false
  gem 'letter_opener_web', '~> 1.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop', require: false
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
