class AddAccessTokenExpiresAtToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :expires_at, :bigint
  end
end
