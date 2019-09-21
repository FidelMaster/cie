# == Schema Information
#
# Table name: admin_cie_role_permissions
#
#  id                :integer          not null, primary key
#  admin_resource_id :integer
#  admin_cie_role_id :integer
#  admin_action_id   :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'test_helper'

class Admin::CieRolePermissionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
