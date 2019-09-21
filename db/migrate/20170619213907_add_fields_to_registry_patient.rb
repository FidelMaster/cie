class AddFieldsToRegistryPatient < ActiveRecord::Migration[5.0]
  def change
    add_column :registry_patients, :father_name, :string
    add_column :registry_patients, :mother_name, :string
    add_reference :registry_patients, :registry_condition, foreign_key: true
    add_column :registry_patients, :reference_to_center, :string
    add_column :registry_patients, :address, :text
    add_column :registry_patients, :phone, :string
    add_column :registry_patients, :mobile_phone, :string
    add_column :registry_patients, :email, :string
    add_column :registry_patients, :comments, :text
  end
end
