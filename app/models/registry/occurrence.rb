# == Schema Information
#
# Table name: registry_occurrences
#
#  id                :integer          not null, primary key
#  registry_event_id :integer
#  date              :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Registry::Occurrence < ApplicationRecord
  belongs_to :registry_event, class_name: 'Registry::Event'
  scope :created_between, -> (start_date, end_date) { where(:created_at => start_date..end_date)}
  attr_accessor :start_time, :hourly_start_time

  def display_event_info
    registry_event.registry_employee.display_name + ' ' + 
    registry_event.registry_patients.map { |patient| patient.display_name + ' ' + (patient.patient_type || '') }.to_s +
      ' ' + registry_event.registry_therapy_room.name
  end

  def self.set_occurrences(start_date, end_date)
    occurrences = Registry::Event.joins(:registry_occurrences).where('registry_occurrences.date between ? and ?', start_date, end_date)
      .select('registry_events.registry_employee_id', 'registry_events.start_time as time',
      'registry_occurrences.date as start_time' ,'registry_occurrences.id')
    
    
    
    puts occurrences.length
    occurrences
    # occurrences = Array.new
    # where('date between ? and ?', start_date, end_date).each do |occurrence|
    #   occurrence.start_time = occurrence.date
    #   occurrence.hourly_start_time = occurrence.registry_event.start_time
    #   puts occurrence.registry_event.id
    #   occurrences << occurrence
    #   puts "==============================================END===================================="
    # end
  end
  
  def therapy_label_color
    registry_event.registry_therapy_room.registry_therapy_type.label_color || '#ffffff'
  end
end
