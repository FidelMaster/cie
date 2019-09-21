class Assigment < ApplicationRecord
  belongs_to :user_user, :classname => "User::User"
  belongs_to :Role
end
