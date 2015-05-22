class PreventDuplicateAssociations < ActiveRecord::Migration
  def change
    # Add unique constraints to indices so that duplicate associations cannot
    # be created.
    change_table(:skills_users) do |t|
      t.remove_index [:user_id, :skill_id]
      t.index        [:user_id, :skill_id], unique: true

      t.remove_index [:skill_id, :user_id]
      t.index        [:skill_id, :user_id], unique: true
    end
  end
end
