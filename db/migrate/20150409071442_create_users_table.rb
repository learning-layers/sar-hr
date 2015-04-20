class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, :null => false
      t.string :password_digest, :null => false
      t.string :first_name, :null => false
      t.string :last_name, :null => false
      t.string :auth_token

      t.timestamps :null => true
    end

    add_index :users, :email
    add_index :users, :auth_token
  end
end
