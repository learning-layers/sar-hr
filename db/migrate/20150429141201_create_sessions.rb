class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.references :user,  null: false
      t.string     :token, null: false
      t.datetime   :expires_on

      t.timestamps null: true
    end

    add_index :sessions, :user_id
    add_index :sessions, :token
  end
end
