module Csvable
	extend ActiveSupport::Concern

	module ClassMethods
		def self.to_csv(options = {})
			CSV.generate(options) do |csv|
				csv << column_names
				all.each do |record|
					csv << record.attributes.values_at(*column_names)
				end
			end
		end
	end
end