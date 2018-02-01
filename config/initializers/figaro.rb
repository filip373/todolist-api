# frozen_string_literal: true

default_keys = %w[
  secret_key_base
]

production_keys = default_keys + %w[
  database_url
]

required = Rails.env.production? ? production_keys : default_keys

Figaro.require_keys required
