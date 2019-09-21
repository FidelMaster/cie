class AddBillableAndCommentsFieldsToRegistryDateEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :registry_date_events, :billable, :boolean
    add_column :registry_date_events, :comments, :text
  end
end
