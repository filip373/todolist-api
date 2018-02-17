# frozen_string_literal: true

class Note < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30 }
  validates :content, length: { maximum: 500 }
end
