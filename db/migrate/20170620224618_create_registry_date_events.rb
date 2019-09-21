class CreateRegistryDateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :registry_date_events do |t|
      t.string :name
      t.text :description
      t.datetime :start_time
      t.datetime :end_time
      t.string :color
      t.string :date_event_type

      t.timestamps
    end
  end
end
