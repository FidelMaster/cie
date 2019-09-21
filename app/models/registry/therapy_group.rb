# == Schema Information
#
# Table name: registry_therapy_groups
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Registry::TherapyGroup < ApplicationRecord
	before_destroy :check_for_event

	has_many :registry_employees, :class_name => "Registry::Employee",
		foreign_key: "registry_therapy_groups_id", :inverse_of => :registry_therapy_group

	has_many :registry_therapy_group_rooms, :class_name => "Registry::TherapyGroupRoom", 
		foreign_key: "registry_therapy_group_id", :inverse_of => :registry_therapy_group, :dependent => :destroy

	has_many :registry_therapy_rooms, :through => :registry_therapy_group_rooms, :class_name => "Registry::TherapyRoom"

	has_many :registry_events, :class_name => "Registry::Event", 
		foreign_key: "registry_therapy_group_id", :inverse_of => :registry_therapy_group

	accepts_nested_attributes_for :registry_therapy_group_rooms,
		:allow_destroy => true,
		:reject_if     => :all_blank

	include AvoidDestroyReferencesUtility 


	def self.get_employers(groupID)
		data = Registry::TherapyGroup.joins(:registry_employees).where(registry_employees: { registry_therapy_groups_id: groupID }).distinct.pluck("registry_employees.first_name")
	end

  	def display_name
		name
	end

  	validates_presence_of :name, :description
  	before_validation :mark_registry_therapy_group_room_for_destruction

	def mark_registry_therapy_group_room_for_destruction
		registry_therapy_group_rooms.each do |registry_therapy_group_room|
			if registry_therapy_group_room.registry_therapy_room.blank?
				registry_therapy_group_room.mark_for_destruction
			end
		end
	end
	def self.security_name
		"Grupo de Terapia"
	end
  	private
  	def check_for_event
		check_for_relation(registry_events, "Evento")
	end
	#def check_for_therapy_group_room
	#	check_for_relation(registry_therapy_group_rooms, "Grupo de Terapia")
	#end
end
