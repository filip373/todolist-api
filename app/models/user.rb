# frozen_string_literal: true

class User < ApplicationRecord
  has_many :lists

  validates :email, presence: true, uniqueness: true
  validates :oauth_id, presence: true
end
