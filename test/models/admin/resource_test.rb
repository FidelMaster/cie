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

require 'test_helper'

class Admin::ResourceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
