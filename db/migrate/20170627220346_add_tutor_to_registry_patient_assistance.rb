class AddTutorToRegistryPatientAssistance < ActiveRecord::Migration[5.0]
  def change
    add_column :registry_patient_assistances, :tutor, :string
  end
end
