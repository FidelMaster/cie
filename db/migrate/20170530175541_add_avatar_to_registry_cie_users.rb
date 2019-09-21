class AddAvatarToRegistryCieUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :registry_cie_users, :avatar, :string
  end
end
