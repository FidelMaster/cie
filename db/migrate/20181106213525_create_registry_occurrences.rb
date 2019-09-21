class CreateRegistryOccurrences < ActiveRecord::Migration[5.0]
  def change
    create_table :registry_occurrences do |t|
      t.references :registry_event, foreign_key: true
      t.datetime :date

      t.timestamps
    end
  end
end
