# frozen_string_literal: true

class User < ApplicationRecord
  validates :oauth_user_id, presence: true
end
