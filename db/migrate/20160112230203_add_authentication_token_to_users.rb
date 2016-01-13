class AddAuthenticationTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :auth_token, :string, deafult: ""
    add_index :users, :auth_token, unique: true
  end
end
