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

require 'test_helper'

class Admin::ParameterTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
