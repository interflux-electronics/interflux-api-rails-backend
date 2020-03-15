module V1
  module Admin
    class CountrySerializer < ApplicationSerializer
      attributes :id,
                 :name_english,
                 :name_native,
                 :two_letter_code,
                 :three_letter_code,
                 :numeric_code,
                 :region,
                 :subregion,
                 :latitude,
                 :longitude,
                 :area,
                 :population,
                 :flag_url,
                 :timezones,
                 :top_level_domains,
                 :calling_codes,
                 :created_at,
                 :updated_at
    end
  end
end
