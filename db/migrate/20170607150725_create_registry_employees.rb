class CreateRegistryEmployees < ActiveRecord::Migration[5.0]
  def change
    create_table :registry_employees do |t|
      t.string :first_name
      t.string :last_name
      t.date :birth_date
      t.references :registry_employee_position, foreign_key: true
      t.date :start_date
      t.boolean :active
      t.string :avatar

      t.timestamps
    end
  end
end
