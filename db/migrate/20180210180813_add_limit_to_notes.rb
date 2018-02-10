# frozen_string_literal: true

class AddLimitToNotes < ActiveRecord::Migration[5.1]
  def change
    change_column :notes, :title, :string, limit: 30
    change_column :notes, :content, :text
  end
end
