# frozen_string_literal: true

default_keys = %w[
  secret_key_base
]

production_keys = default_keys + %w[
  database_url
  raven_dsn
]

required = Rails.env.production? ? production_keys : default_keys

Figaro.require_keys required
