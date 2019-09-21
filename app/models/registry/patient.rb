# == Schema Information
#
# Table name: registry_patients
#
#  id                       :integer          not null, primary key
#  first_name               :string
#  last_name                :string
#  birth_date               :date
#  gender                   :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  father_name              :string
#  mother_name              :string
#  registry_condition_id    :integer
#  reference_to_center      :string
#  address                  :text
#  phone                    :string
#  mobile_phone             :string
#  email                    :string
#  comments                 :text
#  patient_type             :string
#  medical_start_date       :date
#  medical_end_date         :date
#  patient_state            :string
#  child_avatar             :string
#  registry_department_id   :integer
#  registry_municipality_id :integer
#  district                 :string
#  mother_id                :string
#  father_id                :string
#  first_guardian_id        :string
#  first_guardian_name      :string
#  second_guardian_name     :string
#  second_guardian_id       :string
#  schedule                 :string
#  therapy_hours_per_day    :integer
#

class Registry::Patient < ApplicationRecord
	mount_uploader :child_avatar, AvatarUploader
	before_destroy :check_for_event
	
	belongs_to :registry_department, :class_name => "Registry::Department"
	belongs_to :registry_municipality, :class_name => "Registry::Municipality"

	belongs_to :registry_condition, :class_name => "Registry::Condition", :inverse_of => :registry_patients

	has_many :registry_event_patients, :class_name => "Registry::EventPatient", 
		foreign_key: "registry_patient_id", :inverse_of => :registry_patient

	has_many :registry_events, :through => :registry_event_patients, :class_name => "Registry::Event"

	has_one :registry_treatment_requirement, :class_name => "Registry::TreatmentRequirement", 
		foreign_key: "registry_patient_id", :inverse_of => :registry_patient, :dependent => :destroy

	has_many :registry_medical_records, :class_name => "Registry::MedicalRecord", 
		foreign_key: "registry_patient_id", :inverse_of => :registry_patient, :dependent => :destroy

	has_many :registry_date_events, :class_name => "Registry::DateEvent", 
		foreign_key: "registry_patient_id", :inverse_of => :registry_patient

	has_many :registry_patient_assistances, :class_name => "Registry::PatientAssistance", 
		foreign_key: "registry_patient_id", :inverse_of => :registry_patient, :dependent => :destroy

	accepts_nested_attributes_for :registry_patient_assistances,
		:allow_destroy => true,
		:reject_if     => :all_blank
		
	accepts_nested_attributes_for :registry_treatment_requirement,
		:allow_destroy => true,
		:reject_if     => :all_blank
		
	accepts_nested_attributes_for :registry_medical_records,
		:allow_destroy => true,
		:reject_if     => :all_blank

	scope :patient, -> (patient) { where(:id => patient)}
	scope :condition, -> (condition) { where(:registry_condition => condition)}
	scope :gender, -> (gender) { where(:gender => gender)}
	scope :department, -> (department) { where(:registry_department => department)}
	scope :status, -> (status) { status == "En Espera" ? where("patient_state is null") : where(:patient_state => status)}
	scope :district, -> (district) { where(district: district) }
	scope :school_insurance, -> (school_insurance) { joins(:registry_treatment_requirement).merge(Registry::TreatmentRequirement.where(school_insurance: school_insurance)) }
	scope :informed_consent, -> (informed_consent) { joins(:registry_treatment_requirement).merge(Registry::TreatmentRequirement.where(informed_consent: informed_consent)) }
	scope :permission_to_take_photos, -> (permission_to_take_photos) { joins(:registry_treatment_requirement).merge(Registry::TreatmentRequirement.where(permission_to_take_photos: permission_to_take_photos)) }
	scope :patient_type, -> (patient_type) { where(patient_type: patient_type) }
	

	include AvoidDestroyReferencesUtility 
	include PersonalData 
	include Filterable
	include Utility
	include UserModelUtility
	
	validates_format_of :email, 
		:email => true,
		:with => /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, 
		:unless => Proc.new {|c| c.email.blank?},
		:uniqueness => { :case_sensitive => false }
	
	validates_presence_of :gender, :registry_condition, :registry_municipality, :registry_department, 
	:reference_to_center, :address

	#New requirement October 30th, 2018
	# validate :father_or_mother_id

	def self.gender_map
		[["Masculino", "Masculino"],
		 ["Femenino", "Femenino"]]
	end

	def self.status_map
		[["Activo", "Activo"],
		 ["No Activo", "No Activo"],
		 ["En Espera", "En Espera"],
		 ["En Proceso", "En Proceso"]]
	end

	def self.patient_type_map
		[["Privado","Privado"],["INSS","INSS"]]
	end

	def self.security_name
		"Pacientes"
	end
  	def birth_date_formatted
		if !self.new_record?
			birth_date.strftime("%d/%m/%Y")
		else
			birth_date
		end
	end

	def patient_type_map
		["Privado","INSS"]
	end

	def patient_state_map
		[["Activo", "Activo"],["No Activo", "No Activo"],
		 ["En Proceso", "En Proceso"]]
	end

	#New requirement October 30th, 2018
	def self.districts 
		%w[I II III IV V VI VII]
	end

	def start_medical_date_formatted
		if !self.new_record? && medical_start_date.present?
			medical_start_date.strftime("%d/%m/%Y")
		else
			medical_start_date
		end
	end

	def end_medical_date_formatted
		if !self.new_record? && medical_end_date.present?
			medical_end_date.strftime("%d/%m/%Y")
		else
			medical_end_date
		end
	end

  	def display_name
		"#{first_name} #{last_name}"
	end
	def hours_to_invoice(start_date, end_date, invoice_record, patient_hour_record)
		patient_hour_record[self.id.to_s][:total_hours] = 0
		assistances = self.registry_patient_assistances
			.where("registry_patient_assistances.assistance_date between ? and ?",
				Date.strptime(start_date, '%d/%m/%Y').to_s,
				Date.strptime(end_date, '%d/%m/%Y').to_s
			).order(:assistance_date)
		assistances.each do |assistance|
			(Date.strptime(start_date, '%d/%m/%Y') .. Date.strptime(end_date, '%d/%m/%Y')).each do |date|
				if invoice_record[self.id.to_s][date.strftime("%d/%m/%Y")].blank?
					invoice_record[self.id.to_s][date.strftime("%d/%m/%Y")] = {}
				end
				if assistance.assistance_date.strftime("%d/%m/%Y") == date.strftime("%d/%m/%Y") && assistance.employee_who_receives_id?
					invoice_record[self.id.to_s][date.strftime("%d/%m/%Y")][:entrada] = assistance.received_at
				elsif assistance.assistance_date.strftime("%d/%m/%Y") == date.strftime("%d/%m/%Y") && assistance.employee_who_delivers?
					invoice_record[self.id.to_s][date.strftime("%d/%m/%Y")][:salida] = assistance.delivered_at
				end

				if invoice_record[self.id.to_s][date.strftime("%d/%m/%Y")][:entrada].present? &&
					invoice_record[self.id.to_s][date.strftime("%d/%m/%Y")][:salida].present?
					entrada = invoice_record[self.id.to_s][date.strftime("%d/%m/%Y")][:entrada].to_s
					salida = invoice_record[self.id.to_s][date.strftime("%d/%m/%Y")][:salida].to_s
					invoice_record[self.id.to_s][date.strftime("%d/%m/%Y")][:horas] = ((Time.parse(entrada) - Time.parse(salida))/3600).abs
				else 
					invoice_record[self.id.to_s][date.strftime("%d/%m/%Y")][:horas] = 0
				end
			end
		end
		invoice_record[self.id.to_s].each do |hour_by_date|
			patient_hour_record[self.id.to_s][:total_hours] += hour_by_date.last.present? ? hour_by_date.last[:horas] : 0
		end 
	end

	def hours_to_invoice_with_therapy(start_date, end_date, therapy_id, calendar_registry_events)

		start = Date.new.beginning_of_day + 7.hours
		ending = Date.new.end_of_day - 6.hours
		invoice_record = {}
		registered_hours = {}
		therapy_hour = 0
		assistances = self.registry_patient_assistances
			.where("registry_patient_assistances.assistance_date between ? and ?",
				start_date,
				end_date
			).order(:assistance_date, :scenario)
		
		array_date_range = (start_date..end_date).to_a

		assistances.each do |assistance|
						
			array_date_range.each do |date|
				
				if invoice_record[date.strftime("%d/%m/%Y")].blank?
					invoice_record[date.strftime("%d/%m/%Y")] = {}
				end

				if assistance.assistance_date.strftime("%d/%m/%Y") == date.strftime("%d/%m/%Y") && assistance.employee_who_receives_id? && assistance.assistance_date.strftime("%d/%m/%Y") == date.strftime("%d/%m/%Y") && assistance.employee_who_delivers_id?

					invoice_record[date.strftime("%d/%m/%Y")][:entrada] = assistance.received_at
					invoice_record[date.strftime("%d/%m/%Y")][:salida] = assistance.delivered_at
				end

			end
		end
		
		if invoice_record.present?
			array_date_range.each_slice(5) do |week|
	            week.each_with_index do |day, index| 
					while start < ending do
						calendar_registry_events.each do |occurrence|
							
							if occurrence.hourly_start_time.hour == start.hour && occurrence.start_time.to_date == day && occurrence.registry_event.registry_therapy_room.registry_therapy_type_id == therapy_id

						    	if invoice_record[day.strftime("%d/%m/%Y")][:entrada].present? && invoice_record[day.strftime("%d/%m/%Y")][:salida].present?
									entrada = invoice_record[day.strftime("%d/%m/%Y")][:entrada].to_s
									salida = invoice_record[day.strftime("%d/%m/%Y")][:salida].to_s
									
									registered_hours[occurrence.start_time.to_time] = false if registered_hours[occurrence.start_time.to_time].blank?
									
									if occurrence.hourly_start_time.hour >= Time.parse(entrada).hour && occurrence.hourly_start_time.hour <= Time.parse(salida).hour && #!registered_hours[occurrence.start_time.to_time]
										#registered_hours[occurrence.start_time.to_time] = true
										therapy_hour += 1
									end
								end
						    end	
						end 
						start += 1.hour 
					end
					start = Date.new.beginning_of_day + 7.hours
	            end
		    end
		end
		therapy_hour
	end

	def person_label(name)
		label = ''
		if name == mother_name
			label = 'Mamá'
			return label
		end
		if name == father_name
			label = 'Papá'
			return label
		end
		if name == first_guardian_name
			label = 'Tutor 1'
			return label
		end
		if name == second_guardian_name
			label = 'Tutor 2'
			return label
		end
		label = 'Adicional'
	end

	def persons_from_record
		ids = [mother_id, father_id, first_guardian_id, second_guardian_id]
		names = [mother_name, father_name, first_guardian_name, second_guardian_name]
		#ids = ids.reject(&:empty?)
		#names = names.reject(&:empty?)
		#select where element not blank https://stackoverflow.com/questions/3233278/how-do-i-test-if-all-items-in-an-array-are-identical
		ids.zip(names).select { |e| !(e.uniq.length <= 1) }
	end

	#New requirement October 30th, 2018
	def father_or_mother_id
		if father_id.blank? && mother_id.blank?
			errors[:base] << 'Debe ingresar al menos una cédula: de la madre o del padre'
		end
	end

	def schedule
		schedule = Array.new
		events = registry_events.where('start_time >= ? and end_time <= ?', DateTime.now.beginning_of_month, DateTime.now.end_of_month)
		schedule = events.map { |event| event.start_time.strftime("%H:%M") }
		schedule
	end

	private

	def check_for_event
		check_for_relation(registry_events, "Evento")
	end

end
