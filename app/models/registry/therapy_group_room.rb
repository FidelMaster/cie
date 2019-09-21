# == Schema Information
#
# Table name: registry_therapy_group_rooms
#
#  id                        :integer          not null, primary key
#  registry_therapy_group_id :integer
#  registry_therapy_room_id  :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#

class Registry::TherapyGroupRoom < ApplicationRecord
  belongs_to :registry_therapy_group, :class_name => "Registry::TherapyGroup", :inverse_of => :registry_therapy_group_rooms
  belongs_to :registry_therapy_room, :class_name => "Registry::TherapyRoom", :inverse_of => :registry_therapy_group_rooms
  	def self.security_name
		"Salones de Terapia de Grupo"
	end
end
