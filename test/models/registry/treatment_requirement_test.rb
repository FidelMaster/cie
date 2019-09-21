# == Schema Information
#
# Table name: registry_treatment_requirements
#
#  id                                 :integer          not null, primary key
#  registry_patient_id                :integer
#  entrance_letter                    :boolean
#  created_at                         :datetime         not null
#  updated_at                         :datetime         not null
#  epicrisis                          :boolean
#  birth_certificate                  :boolean
#  beneficiary_child_license          :boolean
#  active_secured_parent_id_card      :boolean
#  active_secured_parent_license      :boolean
#  payment_receipt_inss               :boolean
#  beneficiary_social_security_number :string
#  insured_tutor_number               :string
#  other_studies                      :string
#  informed_consent                   :boolean          default(FALSE)
#  permission_to_take_photos          :boolean          default(FALSE)
#  school_insurance                   :boolean          default(FALSE)
#

require 'test_helper'

class Registry::TreatmentRequirementTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
