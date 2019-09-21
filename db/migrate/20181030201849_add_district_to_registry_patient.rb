class AddDistrictToRegistryPatient < ActiveRecord::Migration[5.0]
  def change
    add_column :registry_patients, :district, :string
  end
end
