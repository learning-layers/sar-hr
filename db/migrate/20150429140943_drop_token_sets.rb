class DropTokenSets < ActiveRecord::Migration
  def change
    drop_table :token_sets
  end
end
