class CreateAdminCieRoles < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_cie_roles do |t|
      t.string :name

      t.timestamps
    end
    create_table(:registry_cie_users_registry_cie_roles, :id => false) do |t|
      t.references :registry_cie_user, index: {:name => "index_reg_cie_user_and_role_on_reg_cie_users"} 
      t.references :admin_cie_role, index: {:name => "index_reg_cie_user_and_role_on_admin_cie_roles"} 
    end

    add_index(:admin_cie_roles, :name, name: :cie_roles_name)
    add_index(:registry_cie_users_registry_cie_roles, [ :registry_cie_user_id, :admin_cie_role_id ], name: :cie_roles_user_id_role_id)
  end
end