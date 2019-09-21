class CreateAdminParameters < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_parameters do |t|
      t.decimal :hour_price

      t.timestamps
    end
  end
end
