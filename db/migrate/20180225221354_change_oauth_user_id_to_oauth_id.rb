# frozen_string_literal: true

class ChangeOauthUserIdToOauthId < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :oauth_user_id, :oauth_id
  end
end
