class AddBeneficiarySocialSecurityNumberToRegistryTreatmentRequirement < ActiveRecord::Migration[5.0]
  def change
    add_column :registry_treatment_requirements, :beneficiary_social_security_number, :string
  end
end
