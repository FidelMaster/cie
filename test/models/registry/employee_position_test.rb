# == Schema Information
#
# Table name: registry_employee_positions
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class Registry::EmployeePositionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
