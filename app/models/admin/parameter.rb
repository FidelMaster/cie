# == Schema Information
#
# Table name: admin_parameters
#
#  id                 :integer          not null, primary key
#  inss_hour_price    :decimal(, )
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  private_hour_price :decimal(, )
#  name               :string
#  is_eval            :boolean
#

class Admin::Parameter < ApplicationRecord
	validates_presence_of :inss_hour_price, :private_hour_price, :name
end
