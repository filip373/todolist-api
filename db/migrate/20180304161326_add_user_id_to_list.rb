# frozen_string_literal: true

class AddUserIdToList < ActiveRecord::Migration[5.1]
  def change
    add_reference :lists, :user, index: true
  end
end
