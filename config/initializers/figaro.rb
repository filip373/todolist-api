# frozen_string_literal: true

COMMON_KEYS = %w[
  secret_key_base
].freeze

DEVELOPMENT_KEYS = COMMON_KEYS + %w[
  admin_password
  admin_username
].freeze

PRODUCTION_KEYS = COMMON_KEYS + %w[
  admin_password
  admin_username
  app_env
  database_url
  raven_dsn
].freeze

keys = {
  'test' => COMMON_KEYS,
  'development' => DEVELOPMENT_KEYS,
  'production' => PRODUCTION_KEYS
}

required = keys[Rails.env]
throw "Invalid environment: #{Rails.env}" unless required
Figaro.require_keys required

