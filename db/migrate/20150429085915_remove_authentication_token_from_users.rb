class RemoveAuthenticationTokenFromUsers < ActiveRecord::Migration
  def change
    change_table(:users) do |t|
      t.remove :authentication_token
    end
  end
end
