# == Schema Information
#
# Table name: registry_patient_assistances
#
#  id                       :integer          not null, primary key
#  registry_patient_id      :integer
#  registry_employee_id     :integer
#  scenario                 :string
#  assistance_date          :datetime
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  tutor                    :string
#  personal_code            :string
#  employee_who_receives_id :integer
#  employee_who_delivers_id :integer
#  delivered_at             :time
#  received_at              :time
#

class Registry::PatientAssistance < ApplicationRecord
	belongs_to :registry_patient, :class_name => "Registry::Patient", :inverse_of => :registry_patient_assistances
	belongs_to :registry_employee, :class_name => "Registry::Employee", 
	:inverse_of => :registry_patient_assistances, optional: true

	belongs_to :employee_who_delivers, class_name: 'Registry::Employee', 
	inverse_of: :registry_patient_assistances, optional: true

	belongs_to :employee_who_receives, class_name: 'Registry::Employee', 
	inverse_of: :registry_patient_assistances, optional: true


	# scope :employee_who_delivers, -> (employee) { where(employee_who_delivers: employee) }
	# scope :employee_who_receives, -> (employee) { where(employee_who_receives: employee) }
  	scope :employee, -> (employee) { where('registry_employee_id = ? OR employee_who_delivers_id = ? OR employee_who_receives_id = ?', employee, employee, employee)}
  	scope :tutor, -> (tutor) { where("tutor like ?", "%"+tutor+"%")}
  	#scope :assist_date, -> (assist_date) { where("to_char(assistance_date, 'DD/MM/YYYY') = ?", assist_date)}
  	scope :scenario, -> (scenario) { where(:scenario => scenario)}
  	scope :operator_filter, -> (operator,assist_date) { where("assistance_date #{operator} to_date( ?, 'DD/MM/YYYY' )", assist_date)}

	scope :assistance_date, -> (start_date,end_date) { where("assistance_date >= to_date( ?, 'DD/MM/YYYY' ) and assistance_date <= to_date( ?, 'DD/MM/YYYY' )", start_date, end_date)}
	attr_accessor :date_range
	include Filterable
	validates_presence_of :tutor, :personal_code, :assistance_date
	validate :received_and_delivered
  	def start_time_formatted
  		if assistance_date.present?
			if !self.new_record?
				assistance_date.strftime("%d/%m/%Y")
			else
				assistance_date
			end
		else
			Time.now.strftime("%d/%m/%Y")
		end
	end
	def self.security_name
		"Asistencia"
	end
	def self.scenario_map
		[["Entrada", "Entrada"],
		 ["Salida", "Salida"]]
	end

	def received_and_delivered
		if !new_record?
			if delivered_at <= received_at
				errors[:base] << 'Por favor revisar la hora que entrega. No puede ser menor ni igual a la hora que recibe.'
			end
		end
	end
end
