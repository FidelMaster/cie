module Utility
	extend ActiveSupport::Concern
	
	def self.is_true?(string)
	  ActiveRecord::Type::Boolean.new.cast(string)
	end
	module ClassMethods
		
	end
end