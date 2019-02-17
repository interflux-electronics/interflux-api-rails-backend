module V1
  module Public
    class CountrySerializer < ApplicationSerializer
      attributes :name,
                 :native_name,
                 :region,
                 :subregion,
                 :alpha_2_code,
                 :alpha_3_code,
                 :numeric_code,
                 :flag,
                 :latlng,
                 :area,
                 :population,
                 :languages,
                 :timezones,
                 :currencies,
                 :top_level_domains,
                 :calling_codes,
                 :country_code
    end
  end
end
