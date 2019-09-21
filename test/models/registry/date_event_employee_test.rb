# == Schema Information
#
# Table name: registry_date_event_employees
#
#  id                     :integer          not null, primary key
#  registry_date_event_id :integer
#  registry_employee_id   :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require 'test_helper'

class Registry::DateEventEmployeeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
