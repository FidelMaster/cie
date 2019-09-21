# == Schema Information
#
# Table name: registry_conditions
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Registry::Condition < ApplicationRecord
	before_destroy :check_for_patient

	validates_presence_of :name, :description

	has_many :registry_patients, :class_name => "Registry::Patient", 
		foreign_key: "registry_condition_id", :inverse_of => :registry_condition

	include AvoidDestroyReferencesUtility 
	def self.security_name
		"Condición"
	end
	def display_name
		name
	end

	private
	def check_for_patient
		check_for_relation(registry_patients, "Paciente")
	end
end
