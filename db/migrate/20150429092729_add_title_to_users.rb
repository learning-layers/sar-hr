class AddTitleToUsers < ActiveRecord::Migration
  def change
    change_table(:users) do |t|
      t.string :title
    end
  end
end
