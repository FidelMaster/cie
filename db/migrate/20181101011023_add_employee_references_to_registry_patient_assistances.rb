class AddEmployeeReferencesToRegistryPatientAssistances < ActiveRecord::Migration[5.0]
  def change
    add_column :registry_patient_assistances, :employee_who_receives_id, :integer
    add_column :registry_patient_assistances, :employee_who_delivers_id, :integer
    add_foreign_key :registry_patient_assistances, :registry_employees, column: :employee_who_receives_id
    add_foreign_key :registry_patient_assistances, :registry_employees, column: :employee_who_delivers_id
  end
end
