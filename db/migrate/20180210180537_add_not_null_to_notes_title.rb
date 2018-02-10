# frozen_string_literal: true

class AddNotNullToNotesTitle < ActiveRecord::Migration[5.1]
  def change
    change_column_null :notes, :title, false
  end
end
