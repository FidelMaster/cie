class AddTherapyGroupToRegistryEvent < ActiveRecord::Migration[5.0]
  def change
    add_reference :registry_events, :registry_therapy_group, foreign_key: true
  end
end
