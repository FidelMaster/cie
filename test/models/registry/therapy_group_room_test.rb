# == Schema Information
#
# Table name: registry_therapy_group_rooms
#
#  id                        :integer          not null, primary key
#  registry_therapy_group_id :integer
#  registry_therapy_room_id  :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#

require 'test_helper'

class Registry::TherapyGroupRoomTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
