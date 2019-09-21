class AddEmailToRegistryEmployee < ActiveRecord::Migration[5.0]
  def change
    add_column :registry_employees, :email, :string
  end
end
