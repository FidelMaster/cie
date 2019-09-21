class CreateAssigments < ActiveRecord::Migration[5.0]
  def change
    create_table :assigments do |t|
      t.references :user_user, foreign_key: true
      t.references :role, foreign_key: true
      t.timestamps
    end
  end
end
