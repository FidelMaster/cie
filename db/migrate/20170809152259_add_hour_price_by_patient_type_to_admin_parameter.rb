class AddHourPriceByPatientTypeToAdminParameter < ActiveRecord::Migration[5.0]
  def change
    add_column :admin_parameters, :private_hour_price, :decimal
  end
end
