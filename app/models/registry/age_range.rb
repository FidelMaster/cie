# == Schema Information
#
# Table name: registry_age_ranges
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  min_age     :integer
#  max_age     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Registry::AgeRange < ApplicationRecord
	before_destroy :check_for_level

	has_many :registry_levels, :class_name => "Registry::Level", 
		foreign_key: "facturacion_age_range_id", :inverse_of => :registry_age_range

	include AvoidDestroyReferencesUtility 

	def self.security_name
		"Rangos de Edad"
	end

	def display_name
		"#{name} (#{min_age} - #{max_age}) años"
	end

	validates_presence_of :name, :description, :max_age, :min_age
	validates_numericality_of :max_age, :min_age

	private
	def check_for_level
		check_for_relation(registry_levels, "Área")
	end
end
