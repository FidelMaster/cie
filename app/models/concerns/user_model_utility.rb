module UserModelUtility
	extend ActiveSupport::Concern
	def image_source(method)
		if self.respond_to?(method)
			if self.send(method).is_a?(AvatarUploader)
				if self.send(method).present? 
					self.send(method).url
				else
					"/assets/CIE_logo.png"
				end
			end
		end
	end
	module ClassMethods
		
	end
end
