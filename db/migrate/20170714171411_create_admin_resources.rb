class CreateAdminResources < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_resources do |t|
      t.string :name
      t.text :description
      t.string :model
      t.string :module
      t.references :admin_resource_type, foreign_key: true

      t.timestamps
    end
  end
end
