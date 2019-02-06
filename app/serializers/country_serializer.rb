# == Schema Information
#
# Table name: countries
#
#  id                      :uuid             not null, primary key
#  name_english            :string
#  name_native             :string
#  iso_3161_1_alpha_2_code :string
#  iso_3161_1_alpha_3_code :string
#  iso_3161_1_numeric_code :string
#  region                  :string
#  subregion               :string
#  latitude                :decimal(, )
#  longitude               :decimal(, )
#  area                    :integer
#  population              :integer
#  flag_url                :string
#  timezones               :string
#  top_level_domains       :string
#  calling_codes           :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

class CountrySerializer < ApplicationSerializer
  include FastJsonapi::ObjectSerializer

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
