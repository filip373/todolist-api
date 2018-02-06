# frozen_string_literal: true

source 'https://rubygems.org'
# read ruby version from .ruby-version file
ruby File.read('.ruby-version').strip

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

group :config, :default do
  gem 'figaro'
end

group :core, :default do
  gem 'rails', '~> 5.1.4'
end

group :database, :default do
  gem 'pg', '~> 0.18'
end

group :server, :default do
  gem 'puma', '~> 3.7'
end

group :production do
  gem 'sentry-raven'
end

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'brakeman', require: false
  gem 'foreman', require: false
  gem 'guard', require: false
  gem 'guard-brakeman', require: false
  gem 'guard-rspec', require: false
  gem 'guard-rubocop', require: false
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
