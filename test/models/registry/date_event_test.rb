# == Schema Information
#
# Table name: registry_date_events
#
#  id                  :integer          not null, primary key
#  name                :string
#  description         :text
#  start_time          :datetime
#  end_time            :datetime
#  color               :string
#  date_event_type     :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  registry_patient_id :integer
#  billable            :boolean
#  comments            :text
#  completed_date      :boolean
#  child_guardian      :string
#  phone_number        :string
#  child_name          :string
#

require 'test_helper'

class Registry::DateEventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
