class CreateRegistryAgeRanges < ActiveRecord::Migration[5.0]
  def change
    create_table :registry_age_ranges do |t|
      t.string :name
      t.text :description
      t.integer :min_age
      t.integer :max_age

      t.timestamps
    end
  end
end
