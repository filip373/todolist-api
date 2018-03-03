# frozen_string_literal: true

class AddListIdToNotes < ActiveRecord::Migration[5.1]
  def change
    add_reference :notes, :list, foreign_key: true
  end
end
