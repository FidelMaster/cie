class AddEvaluadorToRegistryCieUser < ActiveRecord::Migration[5.0]
  def change
    add_column :registry_cie_users, :is_evaluator, :boolean
  end
end
