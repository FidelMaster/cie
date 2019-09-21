class CreateRegistryEventPatients < ActiveRecord::Migration[5.0]
  def change
    create_table :registry_event_patients do |t|
      t.references :registry_event, foreign_key: true
      t.references :registry_patient, foreign_key: true

      t.timestamps
    end
  end
end
