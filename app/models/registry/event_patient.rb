# == Schema Information
#
# Table name: registry_event_patients
#
#  id                  :integer          not null, primary key
#  registry_event_id   :integer
#  registry_patient_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Registry::EventPatient < ApplicationRecord
  belongs_to :registry_event, :class_name => "Registry::Event", :inverse_of => :registry_event_patients
  belongs_to :registry_patient, :class_name => "Registry::Patient", :inverse_of => :registry_event_patients

  	def self.security_name
		"Agenda de Paciente"
	end
end
