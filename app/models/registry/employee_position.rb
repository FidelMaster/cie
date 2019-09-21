# == Schema Information
#
# Table name: registry_employee_positions
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Registry::EmployeePosition < ApplicationRecord
	before_destroy :check_for_employee

	has_many :registry_employees, :class_name => "Registry::Employee", 
		foreign_key: "registry_employee_position_id", :inverse_of => :registry_employee_position

	include AvoidDestroyReferencesUtility 

	def display_name
		name
	end

	validates_presence_of :name, :description
	def self.security_name
		"Cargo"
	end

	private
	def check_for_employee
		check_for_relation(registry_employees, "Colaborador")
	end

end
