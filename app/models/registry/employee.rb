# == Schema Information
#
# Table name: registry_employees
#
#  id                            :integer          not null, primary key
#  first_name                    :string
#  last_name                     :string
#  birth_date                    :date
#  registry_employee_position_id :integer
#  start_date                    :date
#  active                        :boolean
#  avatar                        :string
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  email                         :string
#  boss_id                       :integer
#  registry_therapy_group_id     :integer
#

class Registry::Employee < ApplicationRecord

	mount_uploader :avatar, AvatarUploader
	
	before_destroy :check_for_event

	# before_save :check_for_coordinador
	
 	belongs_to :registry_employee_position, :class_name => "Registry::EmployeePosition", :inverse_of => :registry_employees

 	#belongs_to :boss, :class_name => "Registry::Employee"
 	belongs_to :registry_therapy_group, :foreign_key => "registry_therapy_groups_id", :class_name => "Registry::TherapyGroup", :inverse_of => :registry_employees, optional: true

 	has_many :registry_events, :class_name => "Registry::Event", 
		foreign_key: "registry_employee_id", :inverse_of => :registry_employee

	has_many :registry_date_event_employees, :class_name => "Registry::DateEventEmployee", 
		foreign_key: "registry_employee_id", :inverse_of => :registry_employee

	has_one :registry_date_event, :through => :registry_date_event_employees, 
		:class_name=> "Registry::DateEvent", :inverse_of => :registry_employees

	has_many :registry_patient_assistances, :class_name => "Registry::PatientAssistance", 
		foreign_key: "registry_employee_id", :inverse_of => :registry_employee

		has_many :registry_patient_assistances_delivered, :class_name => "Registry::PatientAssistance", 
		foreign_key: "employee_who_delivers_id", :inverse_of => :registry_employee

		has_many :registry_patient_assistances_received, :class_name => "Registry::PatientAssistance", 
		foreign_key: "employee_who_receives_id", :inverse_of => :registry_employee

	scope :employee, -> (employee) { where(:id => employee)}
  	scope :employee_position, -> (employee_position) { where(:registry_employee_position => employee_position)}
  	scope :active, -> (active) { where(:active => active)}

	def self.employers_from_group(groupID)
		sql = "select re.id, re.first_name, re.last_name from registry_employees as re, registry_therapy_groups as tg where re.registry_therapy_group_id = tg.id and tg.id=#{groupID};"
		data = ActiveRecord::Base.connection.execute(sql)
		# data = Registry::Employee.joins(:registry_therapy_group).distinct.select('registry_employees.*').where('registry_therapy_groups_id = ?', groupID)	
		

	end
	def self.id(groupID)
		sql = "select re.id from registry_employees as re, registry_therapy_groups as tg where re.registry_therapy_group_id = tg.id and tg.id=#{groupID};"
		data = ActiveRecord::Base.connection.execute(sql)
		# data = Registry::Employee.joins(:registry_therapy_group).distinct.select('registry_employees.*').where('registry_therapy_groups_id = ?', groupID)	
	end

    #Calculo de Horas Asignadas
	def self.HorasAsignadas(start_date,end_date,emID, groupID)
		sql = "select count(o.id) as Horas from registry_occurrences as o 
		inner join registry_events as 
		e on (o.registry_event_id=e.id) 
		inner join registry_employees as em
		on (e.registry_employee_id=em.id)
		inner join registry_therapy_groups as te 
		on(em.registry_therapy_group_id=te.id) where o.date between '#{start_date}'
		and '#{end_date}' and e.registry_employee_id=#{emID} and em.registry_therapy_group_id=#{groupID}"
		data = ActiveRecord::Base.connection.execute(sql)
		
	   # data = Registry::Employee.joins(:registry_therapy_group).distinct.select('registry_employees.*').where('registry_therapy_groups_id = ?', groupID)	
	end
   #Calculo de Horas Cumplidas
	def self.HorasCumplida(start_date,end_date,emID, groupID)
		sql = "select count(pa.id) as Horas_Cumplidas from registry_patient_assistances as pa
		inner join registry_employees 
		as e on(pa.employee_who_receives_id=e.id) 
		inner join registry_employee_positions as ep
		on(e.registry_employee_position_id=ep.id) 
		where assistance_date between '#{start_date}' and '#{end_date}'
		and pa.employee_who_receives_id=#{emID} 
		and e.registry_therapy_group_id=#{groupID} "
		data = ActiveRecord::Base.connection.execute(sql)
		# data = Registry::Employee.joins(:registry_therapy_group).distinct.select('registry_employees.*').where('registry_therapy_groups_id = ?', groupID)	
	end


	include Filterable

	include AvoidDestroyReferencesUtility 
	include PersonalData 
 	def self.security_name
		"Colaboradores"
	end
	
	def self.get_coordinadores
		Registry::Employee.where(:registry_employee_position_id => Registry::EmployeePosition.where(:name => "Coordinador").first.id)
	end

 	def start_date_formatted
		if !self.new_record?
			start_date.strftime("%d/%m/%Y")
		else
			start_date
		end
	end

	def display_name
		"#{first_name} #{last_name}"
	end

	validates_presence_of :start_date, :registry_employee_position_id

	private
	def check_for_event
		check_for_relation(registry_events, "Evento")
	end
	def check_for_coordinador#(selfPostitionChanged=false)
		employee_therapy_group_related = Registry::Employee.where(:registry_therapy_group_id => self.registry_therapy_group_id, 
				:registry_employee_position_id => Registry::EmployeePosition.where(:name => "Coordinador").first.id)
		if self.registry_employee_position.name == "Coordinador"
			self_employee_relation = employee_therapy_group_related.where(:id => self.id) if self.id.present? 
			if employee_therapy_group_related.present? && self_employee_relation.blank?
				errors.add(:base,"El grupo de terapia #{self.registry_therapy_group.display_name} ya posee un coordinador asociado.")
			end	
		else
			if employee_therapy_group_related.present?
				employee_record = employee_therapy_group_related.where(:id => self.id)
				if employee_record.present? 
					if Registry::Employee.where(:registry_therapy_group_id => self.registry_therapy_group_id, :boss_id => self.id).present?
						errors.add(:base,"El colaborador a modificar es coordinador de el grupo de terapia #{self.registry_therapy_group.display_name}. Existen colaboradores a su cargo, modifique los colaboradores asociados")
					else
						errors.add(:base,"El colaborador a modificar es coordinador de el grupo de terapia #{self.registry_therapy_group.display_name}. Debe existir un coordinador para el grupo de terapia")
					end
				else
					errors.add(:base,"El grupo de terapia #{self.registry_therapy_group.display_name} tiene un coordinador asociado, seleccione el coordinador para poder proceder.") if self.boss_id.blank?
				end
			else
				errors.add(:base,"El grupo de terapia #{self.registry_therapy_group.display_name} NO tiene un coordinador asociado, cree el coordinador para poder proceder.")
			end
		end
		if self.errors.present?
			raise CustomExceptions::SpecialException
		end
	end
end
