class CreateRegistryTreatmentRequirements < ActiveRecord::Migration[5.0]
  def change
    create_table :registry_treatment_requirements do |t|
      t.references :registry_patient, foreign_key: true
      t.boolean :entrance_letter

      t.timestamps
    end
  end
end
