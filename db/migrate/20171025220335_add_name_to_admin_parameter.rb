class AddNameToAdminParameter < ActiveRecord::Migration[5.0]
  def change
    add_column :admin_parameters, :name, :string
    add_column :admin_parameters, :is_eval, :boolean
  end
end
