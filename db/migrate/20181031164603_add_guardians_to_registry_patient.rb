class AddGuardiansToRegistryPatient < ActiveRecord::Migration[5.0]
  def change
    add_column :registry_patients, :first_guardian_id, :string
    add_column :registry_patients, :first_guardian_name, :string
    add_column :registry_patients, :second_guardian_name, :string
    add_column :registry_patients, :second_guardian_id, :string
  end
end
