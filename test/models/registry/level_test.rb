# == Schema Information
#
# Table name: registry_levels
#
#  id                    :integer          not null, primary key
#  name                  :string
#  description           :text
#  registry_age_range_id :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

require 'test_helper'

class Registry::LevelTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
