# frozen_string_literal: true

class User < ApplicationRecord
  validates :oauth_id, presence: true
end
