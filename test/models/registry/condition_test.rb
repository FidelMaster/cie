# == Schema Information
#
# Table name: registry_conditions
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class Registry::ConditionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
