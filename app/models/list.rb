# frozen_string_literal: true

class List < ApplicationRecord
  has_many :notes

  validates :deadline, future: true
  validates :title, presence: true, length: { maximum: 30 }
end
