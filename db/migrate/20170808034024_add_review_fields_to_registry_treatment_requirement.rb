class AddReviewFieldsToRegistryTreatmentRequirement < ActiveRecord::Migration[5.0]
  def change
    add_column :registry_treatment_requirements, :insured_tutor_number, :string
    add_column :registry_treatment_requirements, :other_studies, :string
  end
end
