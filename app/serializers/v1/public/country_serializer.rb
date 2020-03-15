module V1
  module Public
    class CountrySerializer < ApplicationSerializer
      attributes :name_english,
                 :name_native,
                 :two_letter_code,
                 :three_letter_code,
                 :numeric_code,
                 :area,
                 :population
    end
  end
end
