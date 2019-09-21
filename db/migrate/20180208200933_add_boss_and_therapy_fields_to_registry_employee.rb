class AddBossAndTherapyFieldsToRegistryEmployee < ActiveRecord::Migration[5.0]
  def change
    add_column :registry_employees, :boss_id, :integer
    add_reference :registry_employees, :registry_therapy_groups, foreign_key: true
  end
end
