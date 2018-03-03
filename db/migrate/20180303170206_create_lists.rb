# frozen_string_literal: true

class CreateLists < ActiveRecord::Migration[5.1]
  def change
    create_table :lists do |t|
      t.string :title, limit: 30, null: false
      t.datetime :deadline

      t.timestamps
    end
  end
end
