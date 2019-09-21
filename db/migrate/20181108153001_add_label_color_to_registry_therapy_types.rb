class AddLabelColorToRegistryTherapyTypes < ActiveRecord::Migration[5.0]
  def change
    add_column :registry_therapy_types, :label_color, :string, default: '#ffffff'
  end
end
