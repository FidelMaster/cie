# == Schema Information
#
# Table name: admin_permissions
#
#  id                :integer          not null, primary key
#  admin_action_id   :integer
#  admin_resource_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Admin::Permission < ApplicationRecord
  belongs_to :admin_action, :class_name => "Admin::Action"
  belongs_to :admin_resource, :class_name => "Admin::Resource", :inverse_of => :admin_permissions
end
