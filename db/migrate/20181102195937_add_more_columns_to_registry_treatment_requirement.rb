class AddMoreColumnsToRegistryTreatmentRequirement < ActiveRecord::Migration[5.0]
  def change
    add_column :registry_treatment_requirements, :informed_consent, :boolean, default: false
    add_column :registry_treatment_requirements, :permission_to_take_photos, :boolean, default: false
    add_column :registry_treatment_requirements, :school_insurance, :boolean, default: false
  end
end
