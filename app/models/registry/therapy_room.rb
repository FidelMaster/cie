# == Schema Information
#
# Table name: registry_therapy_rooms
#
#  id                       :integer          not null, primary key
#  name                     :string
#  description              :text
#  capacity                 :integer
#  registry_therapy_type_id :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  registry_level_id        :integer
#

class Registry::TherapyRoom < ApplicationRecord
	before_destroy :check_for_event, :check_for_therapy_group_room

  	belongs_to :registry_therapy_type, :class_name => "Registry::TherapyType", :inverse_of => :registry_therapy_rooms
  	belongs_to :registry_level, :class_name => "Registry::Level", :inverse_of => :registry_therapy_rooms
  	
  	has_many :registry_events, :class_name => "Registry::Event", 
		foreign_key: "registry_therapy_room_id", :inverse_of => :registry_therapy_room

	has_many :registry_therapy_group_rooms, :class_name => "Registry::TherapyGroupRoom", 
		foreign_key: "registry_therapy_room_id", :inverse_of => :registry_therapy_room

	include AvoidDestroyReferencesUtility 

  	def display_name
		name
	end
	def self.security_name
		"Salones"
	end
  	validates_presence_of :name, :description, :registry_therapy_type_id, :capacity
  	validates_numericality_of :capacity

  	private
	def check_for_event
		check_for_relation(registry_events, "Evento")
	end
	def check_for_therapy_group_room
		check_for_relation(registry_therapy_group_rooms, "Grupo de Terapia")
	end
end
