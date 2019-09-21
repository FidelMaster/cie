class AddPersonalCodeToRegistryPatientAssistance < ActiveRecord::Migration[5.0]
  def change
    add_column :registry_patient_assistances, :personal_code, :string
  end
end
