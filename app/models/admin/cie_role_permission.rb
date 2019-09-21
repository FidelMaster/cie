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

class Admin::CieRolePermission < ApplicationRecord
	belongs_to :admin_resource, :class_name => "Admin::Resource"
	belongs_to :admin_cie_role, :class_name => "Admin::CieRole"
	belongs_to :admin_action, :class_name => "Admin::Action"
	
	attr_accessor :permission_validator

  	accepts_nested_attributes_for :admin_cie_role,
		:allow_destroy => true,
		:reject_if     => :all_blank
end
