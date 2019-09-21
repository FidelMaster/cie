class CreateRegistryTherapyRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :registry_therapy_rooms do |t|
      t.string :name
      t.text :description
      t.integer :capacity
      t.references :registry_therapy_type, foreign_key: true

      t.timestamps
    end
  end
end
