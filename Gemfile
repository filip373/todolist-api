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
  gem 'rails', '~> 5.1.4'
end

group :database, :default do
  gem 'pg', '~> 0.18'
end

group :docs, :default do
  gem 'swagger_ui_engine'
end

group :server, :default do
  gem 'puma', '~> 3.7'
end

# Non-default groups

group :seeds do
  gem 'faker'
end

# Environment groups

group :production do
  gem 'sentry-raven'
end

group :tests do
  gem 'database_cleaner'
  gem 'shoulda-matchers', '~> 3.1'
end

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
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
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop', require: false
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
