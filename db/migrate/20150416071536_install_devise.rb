class InstallDevise < ActiveRecord::Migration
  def change
    change_table(:users) do |t|
      t.rename :auth_token, :authentication_token
      t.rename :password_digest, :encrypted_password
    end
  end
end
