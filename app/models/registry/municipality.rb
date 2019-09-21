# == Schema Information
#
# Table name: registry_municipalities
#
#  id                     :integer          not null, primary key
#  name                   :string
#  registry_department_id :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class Registry::Municipality < ApplicationRecord
  belongs_to :registry_department, :class_name => "Registry::Department", :inverse_of => :registry_municipalities
  def display_name
  	self.name
  end
  def self.security_name
	"Municipio"
  end
end
