# == Schema Information
#
# Table name: registry_events
#
#  id                        :integer          not null, primary key
#  name                      :string
#  start_time                :datetime
#  recurring                 :text
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  registry_employee_id      :integer
#  registry_therapy_room_id  :integer
#  end_time                  :datetime
#  registry_therapy_group_id :integer
#

require 'test_helper'

class Registry::EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
