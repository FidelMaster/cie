class AddRegistryLevelToRegistryTherapyRoom < ActiveRecord::Migration[5.0]
  def change
    add_reference :registry_therapy_rooms, :registry_level, foreign_key: true
  end
end
