class AddColumnsToRegistryDateEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :registry_date_events, :child_guardian, :string
    add_column :registry_date_events, :phone_number, :string
    add_column :registry_date_events, :child_name, :string
  end
end
