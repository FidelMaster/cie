class FixHourPriceColumnName < ActiveRecord::Migration[5.0]
	def change
   		rename_column :admin_parameters, :hour_price, :inss_hour_price
  	end
end
