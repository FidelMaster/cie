class Role < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    has_many :assigments
    has_many :user_users , :classname => "User::User", through: :assigments    
end
