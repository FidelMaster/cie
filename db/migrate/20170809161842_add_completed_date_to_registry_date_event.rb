class AddCompletedDateToRegistryDateEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :registry_date_events, :completed_date, :boolean
  end
end
