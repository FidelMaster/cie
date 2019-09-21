class CreateRegistryMunicipalities < ActiveRecord::Migration[5.0]
  def change
    create_table :registry_municipalities do |t|
      t.string :name
      t.references :registry_department, foreign_key: true

      t.timestamps
    end
  end
end
