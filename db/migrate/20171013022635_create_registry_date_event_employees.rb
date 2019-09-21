class CreateRegistryDateEventEmployees < ActiveRecord::Migration[5.0]
  def change
    create_table :registry_date_event_employees do |t|
      t.references :registry_date_event, foreign_key: true
      t.references :registry_employee, foreign_key: true

      t.timestamps
    end
  end
end
