class CreateRegistryTherapyTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :registry_therapy_types do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
