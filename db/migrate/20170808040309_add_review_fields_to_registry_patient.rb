class AddReviewFieldsToRegistryPatient < ActiveRecord::Migration[5.0]
  def change
    add_column :registry_patients, :patient_type, :string
    add_column :registry_patients, :medical_start_date, :date
    add_column :registry_patients, :medical_end_date, :date
    add_column :registry_patients, :patient_state, :string
  end
end
