# == Schema Information
#
# Table name: registry_patient_assistances
#
#  id                       :integer          not null, primary key
#  registry_patient_id      :integer
#  registry_employee_id     :integer
#  scenario                 :string
#  assistance_date          :datetime
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  tutor                    :string
#  personal_code            :string
#  employee_who_receives_id :integer
#  employee_who_delivers_id :integer
#  delivered_at             :time
#  received_at              :time
#

require 'test_helper'

class Registry::PatientAssistanceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
