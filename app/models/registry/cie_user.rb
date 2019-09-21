# == Schema Information
#
# Table name: registry_cie_users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  avatar                 :string
#  name                   :string
#  is_evaluator           :boolean
#

class Registry::CieUser < ApplicationRecord
	mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  	
  	has_and_belongs_to_many :admin_cie_roles, :class_name => "Admin::CieRole",
  		:join_table => :registry_cie_users_registry_cie_roles, foreign_key: "registry_cie_user_id",
  		association_foreign_key: "admin_cie_role_id"

    validates_presence_of :admin_cie_roles
    validates_uniqueness_of :email
  	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	include UserModelUtility
	def self.security_name
		"Usuario de Registro"
	end

  def display_name
    self.name
  end
end
