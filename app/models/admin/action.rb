# == Schema Information
#
# Table name: admin_actions
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Admin::Action < ApplicationRecord
end
