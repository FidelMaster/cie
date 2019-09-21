class AddDeliveredAtAndReceivedAtToRegistryPatientAssistances < ActiveRecord::Migration[5.0]
  def change
    add_column :registry_patient_assistances, :delivered_at, :time
    add_column :registry_patient_assistances, :received_at, :time
  end
end
