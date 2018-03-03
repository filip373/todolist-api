# frozen_string_literal: true

class Note < ApplicationRecord
  belongs_to :list, optional: true

  validates :content, length: { maximum: 500 }
  validates :list, presence: true, if: Proc.new { |l| l.list_id }
  validates :title, presence: true, length: { maximum: 30 }
end
