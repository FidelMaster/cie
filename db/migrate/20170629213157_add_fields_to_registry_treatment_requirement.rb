class AddFieldsToRegistryTreatmentRequirement < ActiveRecord::Migration[5.0]
  def change
    add_column :registry_treatment_requirements, :epicrisis, :boolean
    add_column :registry_treatment_requirements, :birth_certificate, :boolean
    add_column :registry_treatment_requirements, :beneficiary_child_license, :boolean
    add_column :registry_treatment_requirements, :active_secured_parent_id_card, :boolean
    add_column :registry_treatment_requirements, :active_secured_parent_license, :boolean
    add_column :registry_treatment_requirements, :payment_receipt_inss, :boolean
  end
end
