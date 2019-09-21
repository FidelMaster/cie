# == Schema Information
#
# Table name: registry_occurrences
#
#  id                :integer          not null, primary key
#  registry_event_id :integer
#  date              :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'test_helper'

class Registry::OccurrenceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
