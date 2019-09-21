# == Schema Information
#
# Table name: registry_departments
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Registry::Department < ApplicationRecord
	has_many :registry_municipalities, :class_name => "Registry::Municipality", 
		foreign_key: "registry_department_id", :inverse_of => :registry_department

	def display_name
		self.name
	end
	def self.security_name
		"Departamento"
	end
end
