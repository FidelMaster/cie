# == Schema Information
#
# Table name: admin_cie_roles
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Admin::CieRole < ApplicationRecord
	before_destroy :check_for_users

	has_and_belongs_to_many :registry_cie_users, :class_name => "Registry::CieUser", 
		:join_table => :registry_cie_users_registry_cie_roles, foreign_key: "admin_cie_role_id",
		association_foreign_key: "registry_cie_user_id"

  	has_many :admin_cie_role_permissions, :class_name => "Admin::CieRolePermission", :dependent => :destroy,
		foreign_key: "admin_cie_role_id", :inverse_of => :admin_cie_role

	def display_name
		self.name
	end
	validates_presence_of :name
	include AvoidDestroyReferencesUtility 

  	private
	def check_for_users
		check_for_relation(registry_cie_users, "Usuario")
	end
end
