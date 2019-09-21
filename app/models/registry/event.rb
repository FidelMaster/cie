# == Schema Information
#
# Table name: registry_events
#
#  id                        :integer          not null, primary key
#  name                      :string
#  start_time                :datetime
#  recurring                 :text
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  registry_employee_id      :integer
#  registry_therapy_room_id  :integer
#  end_time                  :datetime
#  registry_therapy_group_id :integer
#

class Registry::Event < ApplicationRecord
	belongs_to :registry_therapy_group, :class_name => "Registry::TherapyGroup", :inverse_of => :registry_events
	belongs_to :registry_therapy_room, :class_name => "Registry::TherapyRoom", :inverse_of => :registry_events
	belongs_to :registry_employee, :class_name => "Registry::Employee", :inverse_of => :registry_events

	has_many :registry_event_patients, :class_name => "Registry::EventPatient", :dependent => :destroy,
		foreign_key: "registry_event_id", :inverse_of => :registry_event
	
	has_many :registry_occurrences, class_name: 'Registry::Occurrence', dependent: :destroy, 
		foreign_key: "registry_event_id", inverse_of: :registry_event
	
	has_many :registry_patients, :through => :registry_event_patients, :class_name => "Registry::Patient"

	accepts_nested_attributes_for :registry_event_patients,
		:allow_destroy => true,
		:reject_if     => :all_blank

	scope :patient, -> (patient) { joins(:registry_event_patients).where(:"registry_event_patients.registry_patient_id" => patient)}
	scope :employee, -> (employee) { where(:registry_employee => employee)}
	scope :therapy_room, -> (room) { where(:registry_therapy_room => room)}
	scope :therapy_group, -> (group) { where(:registry_therapy_group => group)}


	scope :scoped_events, -> (record) {
		where("registry_events.id <> ?",record.id) if !record.new_record? 
	}

	
	include Filterable
	include ActiveModel::Validations

  	validates_with Validator::EventValidator
	
	validates_presence_of :registry_employee_id, :registry_therapy_room_id, :registry_event_patient_ids

	validates :end_time, date: {on_or_after: :start_time}

	serialize :recurring, Hash
	attr_accessor :hourly_start_time
	before_validation :mark_registry_event_patient_for_destruction

	after_save :occurrences

	attr_accessor :times
	
	def self.security_name
		"Agenda"
	end

	def mark_registry_event_patient_for_destruction
		registry_event_patients.each do |registry_event_patient|
			if registry_event_patient.registry_patient.blank?
				registry_event_patient.mark_for_destruction
			end
		end
	end

	def display_name
		name
	end

	def start_time_formatted
		if !self.new_record? || self.start_time.present?
			start_time.strftime("%d/%m/%Y %T")
		else
			start_time
		end
	end
	def end_time_formatted
		if end_time.present?
			if !self.new_record? || self.end_time.present?
				end_time.strftime("%d/%m/%Y")
			else
				end_time
			end
		else
		  Date.today.strftime("%d/%m/%Y")
		end
		# end_time
	end
	def recurring=(value)
		if RecurringSelect.is_valid_rule?(value) && !value.nil?
			super(RecurringSelect.dirty_hash_to_rule(value).to_hash)
		else
			super(nil)
		end
	end
	def rule
		IceCube::Rule.from_hash recurring
	end
	def schedule(start)
		schedule = IceCube::Schedule.new(start)
		schedule.add_recurrence_rule(rule)
		schedule
	end
	def calendar_events(start, custom_end_date = nil)
		occurrences = []
		if recurring.empty?
			self.hourly_start_time = start_time
			[self]
		else
			start_date = start
			if self.end_time.present?
				self.end_time = self.end_time + 1.day 
			end
			if custom_end_date.present?
				end_date = custom_end_date
			else
				end_date = self.end_time || start_date
			end
			if !registry_occurrences.empty?
				registry_occurrences.each do |registry_occurrence|
					registry_occurrence.start_time = registry_occurrence.date
					registry_occurrence.hourly_start_time = start_time
					occurrences << registry_occurrence
				end
			else
				schedule(start_date).occurrences(end_date).map do |date|
					occurrences << Registry::Event.new(id:id, name:name, registry_employee_id: registry_employee_id, 
						registry_patient_ids: registry_patient_ids, registry_therapy_room_id: registry_therapy_room_id,
						start_time:date.change(:hour => start_time.hour), hourly_start_time:start_time)
				end
			end
			occurrences
		end

	end

	def occurrences
		start_date = start_time
		end_date = end_time + 1.day
		schedule = schedule(start_date).occurrences(end_date)
		if registry_occurrences.empty?
			schedule.map do |date|
				registry_occurrences << Registry::Occurrence.new({ date: date.to_date })
			end
		else
			occurrences_ahead = registry_occurrences.where 'date(date) >= ?', Date.today
			unless occurrences_ahead.empty?
				schedule = schedule(occurrences_ahead.first.date).occurrences end_date
				# I think this is of no use. It might be registry_ocurrences.delete_all but let's see how it behaves
				# occurrences_ahead.delete_all
				schedule.map do |date|
					registry_occurrences << Registry::Occurrence.new({ date: date.to_date })
				end
			end
		end
	end

	def self.date_range(start_date, end_date)
		beginning = start_date.beginning_of_week
		ending    = end_date.end_of_week
		(beginning..ending).to_a
	end

	def self.days_of_the_week(start_date, end_date)
		week_days = Array.new
		date_range = self.date_range(start_date, end_date) 
		week_count = date_range.count / 7 
		week_count.times do |week_number| 
			if week_number == 0 
				week_days << (date_range.first...(date_range.first+7.days)).to_a 
			else 
				week_days << (week_days.last.last+1.day...(week_days.last.last+1.day+7.days)).to_a 
			end 
		end 
		puts week_days.to_json
		week_days
	end
	
	def simple_calendar_events_array(start)
		if recurring.empty?
			[{date_start_time:start_time.strftime("%d/%m/%Y"), hour_start_time:start_time.hour}]
		else
			start_date = start_time
			if end_time.present?
				end_date = end_time + 1.day 
			else
				end_date = start_date
			end
			schedule(start_date).occurrences(end_date).map do |date|
				{date_start_time:date.strftime("%d/%m/%Y"), hour_start_time:date.hour}
			end
		end
	end
end
