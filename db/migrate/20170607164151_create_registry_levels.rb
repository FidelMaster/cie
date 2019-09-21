class CreateRegistryLevels < ActiveRecord::Migration[5.0]
  def change
    create_table :registry_levels do |t|
      t.string :name
      t.text :description
      t.references :registry_age_range, foreign_key: true

      t.timestamps
    end
  end
end
