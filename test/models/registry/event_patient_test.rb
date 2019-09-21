# == Schema Information
#
# Table name: registry_event_patients
#
#  id                  :integer          not null, primary key
#  registry_event_id   :integer
#  registry_patient_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'test_helper'

class Registry::EventPatientTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
