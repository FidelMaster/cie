# == Schema Information
#
# Table name: registry_therapy_types
#
#  id                    :integer          not null, primary key
#  name                  :string
#  description           :text
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  private_therapy_price :decimal(, )
#  inss_therapy_price    :decimal(, )
#  label_color           :string
#

class Registry::TherapyType < ApplicationRecord
	before_destroy :check_for_therapy_room, :check_for_medical_record

	has_many :registry_therapy_rooms, :class_name => "Registry::TherapyRoom", 
		foreign_key: "registry_therapy_type_id", :inverse_of => :registry_therapy_type
	
	has_many :registry_medical_records, :class_name => "Registry::MedicalRecord", 
		foreign_key: "registry_therapy_type_id", :inverse_of => :registry_therapy_type

	include AvoidDestroyReferencesUtility 

	def display_name
		name
	end

	validates_presence_of :name, :description, :private_therapy_price, :inss_therapy_price
	validates_numericality_of :private_therapy_price, :inss_therapy_price
	
	def self.security_name
		"Tipos de Terapia"
	end
	
	private
	def check_for_therapy_room
		check_for_relation(registry_therapy_rooms, "Salón")
	end
	def check_for_medical_record
		check_for_relation(registry_medical_records, "Fichas clínicas")
	end
end
