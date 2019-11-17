module V1
  module Public
    class CountrySerializer < ApplicationSerializer
      attributes :name_english,
                 :name_native,
                 # :region,
                 # :subregion,
                 :alpha_2_code,
                 :alpha_3_code,
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
