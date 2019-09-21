module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def filter(filtering_params)
      results = self.where(nil)
      filtering_params.each do |key, value|
        if value.class.eql? Array
          results = results.public_send(key, *value) if value.present?
        else
          results = results.public_send(key, value) if value.present?
        end
      end
      results
    end
  end
end
