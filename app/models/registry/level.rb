# == Schema Information
#
# Table name: registry_levels
#
#  id                    :integer          not null, primary key
#  name                  :string
#  description           :text
#  registry_age_range_id :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class Registry::Level < ApplicationRecord
	before_destroy :check_for_therapy_room

	belongs_to :registry_age_range, :class_name => "Registry::AgeRange", :inverse_of => :registry_levels

	has_many :registry_therapy_rooms, :class_name => "Registry::TherapyRoom", 
		foreign_key: "registry_level_id", :inverse_of => :registry_level
  	
  	include AvoidDestroyReferencesUtility 

  	def display_name
		name
	end

	def self.security_name
		"Áreas"
	end
  	
  	validates_presence_of :name, :description, :registry_age_range_id

  	private
	def check_for_therapy_room
		check_for_relation(registry_therapy_rooms, "Salón")
	end
end
