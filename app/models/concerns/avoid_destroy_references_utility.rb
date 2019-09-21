module AvoidDestroyReferencesUtility
	extend ActiveSupport::Concern
	
	private

	def check_for_relation(relation, model_name)
		if relation.count > 0
			errors.add(:base,"No es posible eliminar el registro #{self.display_name}, esta asociado a #{relation.count} #{model_name}(s).")
			raise CustomExceptions::RecordAssociationException
			#return false
		end
	end

	module ClassMethods
		
	end
end
