# == Schema Information
#
# Table name: admin_resource_types
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Admin::ResourceType < ApplicationRecord
	has_many :admin_resources
end
