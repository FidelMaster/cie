# == Schema Information
#
# Table name: admin_permissions
#
#  id                :integer          not null, primary key
#  admin_action_id   :integer
#  admin_resource_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'test_helper'

class Admin::PermissionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
