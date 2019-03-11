module V1
  module Admin
    class CountrySerializer < ApplicationSerializer
       attributes :id,
                  :name_english,
                  :name_native,
                  :iso_3161_1_alpha_2_code,
                  :iso_3161_1_alpha_3_code,
                  :iso_3161_1_numeric_code,
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
