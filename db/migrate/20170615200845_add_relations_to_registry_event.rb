class AddRelationsToRegistryEvent < ActiveRecord::Migration[5.0]
  def change
    add_reference :registry_events, :registry_employee, foreign_key: true
    add_reference :registry_events, :registry_therapy_room, foreign_key: true
  end
end
