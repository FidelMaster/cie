# == Schema Information
#
# Table name: registry_therapy_types
#
#  id                    :integer          not null, primary key
#  name                  :string
#  description           :text
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  private_therapy_price :decimal(, )
#  inss_therapy_price    :decimal(, )
#  label_color           :string
#

require 'test_helper'

class Registry::TherapyTypeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
