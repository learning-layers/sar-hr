class CreateTokenSets < ActiveRecord::Migration
  def change
    create_table :token_sets do |t|
      t.string :identifier, null: false
      t.text   :tokens,     null: false
    end

    add_index :token_sets, :identifier
  end
end
