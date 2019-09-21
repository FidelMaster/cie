class AddIndexToRegistryPatientEvent < ActiveRecord::Migration[5.0]
  def change
    add_index :registry_patient_assistances, :assistance_date
  	add_index :registry_patient_assistances, :scenario
  	add_index :registry_employees, :boss_id
  	add_index :registry_events, :start_time
  end
end
