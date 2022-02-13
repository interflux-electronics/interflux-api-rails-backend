module V1
  module Admin
    class LanguageSerializer < ApplicationSerializer
      attributes :name_english,
                 :name_native,
                 :three_letter_code,
                 :public

      has_many :countries, if: requested?('countries')
      has_many :country_languages, if: requested?('country_languages')
    end
  end
end
