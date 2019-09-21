# == Schema Information
#
# Table name: registry_therapy_rooms
#
#  id                       :integer          not null, primary key
#  name                     :string
#  description              :text
#  capacity                 :integer
#  registry_therapy_type_id :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  registry_level_id        :integer
#

require 'test_helper'

class Registry::TherapyRoomTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
