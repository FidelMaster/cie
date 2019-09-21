class AddPriceToRegistryTherapyType < ActiveRecord::Migration[5.0]
  def change
    add_column :registry_therapy_types, :private_therapy_price, :decimal
    add_column :registry_therapy_types, :inss_therapy_price, :decimal
  end
end
