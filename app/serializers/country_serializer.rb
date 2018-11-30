# == Schema Information
#
# Table name: countries
#
#  id                :uuid             not null, primary key
#  name              :text
#  native_name       :text
#  region            :text
#  subregion         :text
#  alpha_2_code      :text
#  alpha_3_code      :text
#  numeric_code      :text
#  flag              :text
#  latlng            :text
#  area              :decimal(, )
#  population        :decimal(, )
#  languages         :text
#  timezones         :text
#  currencies        :text
#  top_level_domains :text
#  calling_codes     :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
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
