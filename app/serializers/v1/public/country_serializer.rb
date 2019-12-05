module V1
  module Public
    class CountrySerializer < ApplicationSerializer
      attributes :name_english,
                 :name_native,
                 # :region,
                 # :subregion,
                 :two_letter_code,
                 :three_letter_code,
                 :numeric_code,
                 # :region,
                 # :subregion,
                 # :latitude,
                 # :longitude,
                 :area,
                 :population
                 # :flag_url,
                 # :timezones,
                 # :top_level_domains,
                 # :calling_codes
    end
  end
end
