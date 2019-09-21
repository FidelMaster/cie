class AddNameToRegistryCieUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :registry_cie_users, :name, :string
  end
end
