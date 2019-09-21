# == Schema Information
#
# Table name: registry_date_events
#
#  id                  :integer          not null, primary key
#  name                :string
#  description         :text
#  start_time          :datetime
#  end_time            :datetime
#  color               :string
#  date_event_type     :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  registry_patient_id :integer
#  billable            :boolean
#  comments            :text
#  completed_date      :boolean
#  child_guardian      :string
#  phone_number        :string
#  child_name          :string
#

class Registry::DateEvent < ApplicationRecord
	attr_accessor :date_range

	has_many :registry_date_event_employees, :class_name => "Registry::DateEventEmployee", 
		foreign_key: "registry_date_event_id", :inverse_of => :registry_date_event, :dependent => :destroy

	has_many :registry_employees, :through => :registry_date_event_employees, 
		:class_name => "Registry::Employee", :inverse_of => :registry_date_event

	belongs_to :registry_patient, :class_name => "Registry::Patient", :inverse_of => :registry_date_events, optional: true
	
	accepts_nested_attributes_for :registry_date_event_employees,
		:allow_destroy => true,
		:reject_if     => :all_blank
		
	def color_map
		[
			["Plata","#efefef"],
			["Gris","#c4c4c4"],
			["Negro","#000000"],
			["Marrón","#f1e3d1"],
			["Amarillo","#fffcdb"],
			["Oliva","#d9d9b2"],
			["Lima","#b2ffb2"],
			["Verde","#b2d9b2"],
			["Aqua","#ccffff"],
			["Verde Azulado","#b6daff"],
			["Azul","#0c84ff"],
			["Fucsia","#e0b6ea"],
			["Púrpura","#7300a9"],	
			['Rojo','#ffcccc'], 
			['Naranja','#ff7e00'], 
			['Cyan','#ccebf8'], 
			['Rosado','#f95aff'],
		]
	end

	def text_color_hash
		{
			"#efefef"=>"#878787",
			"#c4c4c4"=>"#888888",
			"#000000"=>"#4e4e4e",
			"#f1e3d1"=>"#ea6666",
			"#fffcdb"=>"#be8e50",
			"#d9d9b2"=>"#cdb200",
			"#b2ffb2"=>"#7e7e21",
			"#b2d9b2"=>"#629f62",
			"#ccffff"=>"#4f954f",
			"#b6daff"=>"#229c9c",
			"#0c84ff"=>"#c0c0ef",
			"#e0b6ea"=>"#6d1f81",
			"#7300a9"=>"#6f09b6",	
			'#ffcccc'=>"#b14f4f", 
			'#ff7e00'=>"#c37f3d", 
			'#ccebf8'=>"#009bdb", 
			'#f95aff'=>"#db4ac8",
		}
	end

	def start_time_formatted
		start_time.strftime("%d/%m/%Y %T")
	end

	def self.security_name
		"Citas"
	end
	def display_name
		name
	end

	def event_type_map 
		[['Cita','Cita'], ['Evaluación','Evaluación']]
	end
  	
  	def all_day_event?
  		self.end_time = self.end_time.present? ? self.end_time : self.start_time.midnight
    	self.start_time == self.start_time.midnight && self.end_time.present? && self.end_time == self.end_time.midnight ? true : false
	end
end
