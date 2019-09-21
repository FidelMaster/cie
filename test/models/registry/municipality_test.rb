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

require 'test_helper'

class Registry::MunicipalityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
