class CreateAdminCieRolePermissions < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_cie_role_permissions do |t|
      t.references :admin_resource, foreign_key: true
      t.references :admin_cie_role, foreign_key: true
      t.references :admin_action, foreign_key: true

      t.timestamps
    end
  end
end
