# == Schema Information
#
# Table name: registry_date_event_employees
#
#  id                     :integer          not null, primary key
#  registry_date_event_id :integer
#  registry_employee_id   :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class Registry::DateEventEmployee < ApplicationRecord
  belongs_to :registry_date_event, :class_name => "Registry::DateEvent", :inverse_of => :registry_date_event_employees
  belongs_to :registry_employee, :class_name => "Registry::Employee", :inverse_of => :registry_date_event_employees
end
