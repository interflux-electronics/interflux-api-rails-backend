module V1
  module Admin
    class CountryLanguageSerializer < ApplicationSerializer
      belongs_to :country
      belongs_to :language
    end
  end
end
