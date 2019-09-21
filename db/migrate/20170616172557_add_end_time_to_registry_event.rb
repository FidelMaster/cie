class AddEndTimeToRegistryEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :registry_events, :end_time, :datetime
  end
end
