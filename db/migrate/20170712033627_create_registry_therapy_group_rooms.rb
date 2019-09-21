class CreateRegistryTherapyGroupRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :registry_therapy_group_rooms do |t|
      t.references :registry_therapy_group, foreign_key: true
      t.references :registry_therapy_room, foreign_key: true

      t.timestamps
    end
  end
end
