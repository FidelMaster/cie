class CreateRegistryPatientAssistances < ActiveRecord::Migration[5.0]
  def change
    create_table :registry_patient_assistances do |t|
      t.references :registry_patient, foreign_key: true
      t.references :registry_employee, foreign_key: true
      t.string :scenario
      t.datetime :assistance_date

      t.timestamps
    end
  end
end
