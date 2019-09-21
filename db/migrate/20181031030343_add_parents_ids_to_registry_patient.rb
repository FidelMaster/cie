class AddParentsIdsToRegistryPatient < ActiveRecord::Migration[5.0]
  def change
    add_column :registry_patients, :mother_id, :string
    add_column :registry_patients, :father_id, :string
  end
end
