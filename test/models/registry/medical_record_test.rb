# == Schema Information
#
# Table name: registry_medical_records
#
#  id                       :integer          not null, primary key
#  registry_patient_id      :integer
#  registry_therapy_type_id :integer
#  week_therapy_hours       :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#

require 'test_helper'

class Registry::MedicalRecordTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
