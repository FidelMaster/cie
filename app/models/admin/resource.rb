# == Schema Information
#
# Table name: admin_resources
#
#  id                     :integer          not null, primary key
#  name                   :string
#  description            :text
#  model                  :string
#  module                 :string
#  admin_resource_type_id :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class Admin::Resource < ApplicationRecord
  belongs_to :admin_resource_type, :class_name => "Admin::ResourceType"
  has_many :admin_permissions, :class_name => "Admin::Permission", foreign_key: "admin_resource_id", inverse_of: :admin_resource
end
