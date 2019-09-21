# == Schema Information
#
# Table name: registry_age_ranges
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  min_age     :integer
#  max_age     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class Registry::AgeRangeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
