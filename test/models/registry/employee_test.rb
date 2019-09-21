# == Schema Information
#
# Table name: registry_employees
#
#  id                            :integer          not null, primary key
#  first_name                    :string
#  last_name                     :string
#  birth_date                    :date
#  registry_employee_position_id :integer
#  start_date                    :date
#  active                        :boolean
#  avatar                        :string
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  email                         :string
#  boss_id                       :integer
#  registry_therapy_group_id     :integer
#

require 'test_helper'

class Registry::EmployeeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
