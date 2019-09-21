class AddGenderIndexToRegistryPatient < ActiveRecord::Migration[5.0]
  def change
    add_index :registry_patients, :gender
  end
end
