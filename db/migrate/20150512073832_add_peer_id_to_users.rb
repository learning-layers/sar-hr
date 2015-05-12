class AddPeerIdToUsers < ActiveRecord::Migration
  def change
    change_table(:users) do |t|
      t.string :peer_id
    end
  end
end
