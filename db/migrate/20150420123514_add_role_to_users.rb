class AddRoleToUsers < ActiveRecord::Migration
  def change
    change_table(:users) do |t|
      t.integer :role, default: 0, null: false
    end
  end
end
