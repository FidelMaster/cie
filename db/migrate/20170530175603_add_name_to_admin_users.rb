class AddNameToAdminUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :admin_admin_users, :name, :string
  end
end
