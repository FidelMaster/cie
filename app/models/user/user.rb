class User::User < ApplicationRecord
  has_many :assingments
  has_many :roles, through: :assingments
  
 
 
  # def role?(role, entity_id = nil)
  #   if entity_id.present?
  #     roles.where(entity_id: entity_id, name: role).any?
  #   else
  #     logger.warn "Role check used without an entity id presented"
  #     #{role} called for #{id} user"
  #     roles.any? {|r| r.name.to_sym == role}
  #   end
  # end
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
