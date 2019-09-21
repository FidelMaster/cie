module PersonalData
	extend ActiveSupport::Concern
	include ActiveModel::Validations

	included do 
		validates_presence_of :first_name, :last_name
		validates :birth_date, presence: true, date: {on_or_after: :birth_date_first, on_or_before: :birth_date_last}
		def self.birth_date_first
		    60.years.ago
		end

		def self.birth_date_last
			2.month.ago
		end
	end
	def birth_date_formatted
		if !self.new_record?
			birth_date.strftime("%d/%m/%Y")
		else
			birth_date
		end
	end
	def age
		dob = self.birth_date
		now = Time.now.utc.to_date
		now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
	end

	def image_source(method)
		if self.respond_to?(method)
			if self.send(method).is_a?(AvatarUploader)
				if self.send(method).present? 
					self.send(method).url
				else
					"/assets/CIE_logo.jpg"
				end
			end
		end
	end
	module ClassMethods

	end
end
