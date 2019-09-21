class CreateRegistryMedicalRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :registry_medical_records do |t|
      t.references :registry_patient, foreign_key: true
      t.references :registry_therapy_type, foreign_key: true
      t.integer :week_therapy_hours

      t.timestamps
    end
  end
end
