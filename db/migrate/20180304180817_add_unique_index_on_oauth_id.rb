class AddUniqueIndexOnOauthId < ActiveRecord::Migration[5.1]
  def change
    add_index :users, :oauth_id, unique: true
  end
end
