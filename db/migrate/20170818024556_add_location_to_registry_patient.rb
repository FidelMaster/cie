class AddLocationToRegistryPatient < ActiveRecord::Migration[5.0]
  def change
    add_reference :registry_patients, :registry_department, foreign_key: true
    add_reference :registry_patients, :registry_municipality, foreign_key: true
  end
end
