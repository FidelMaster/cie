# == Schema Information
#
# Table name: registry_medical_records
#
#  id                       :integer          not null, primary key
#  registry_patient_id      :integer
#  registry_therapy_type_id :integer
#  week_therapy_hours       :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#

class Registry::MedicalRecord < ApplicationRecord
  belongs_to :registry_patient, :class_name => "Registry::Patient", :inverse_of => :registry_medical_records
  belongs_to :registry_therapy_type, :class_name => "Registry::TherapyType", :inverse_of => :registry_medical_records

  	def self.security_name
		"Ficha Clínica"
	end
end
