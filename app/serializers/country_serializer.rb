# == Schema Information
#
# Table name: countries
#
#  id                :uuid             not null, primary key
#  name              :string
#  native_name       :string
#  region            :string
#  subregion         :string
#  alpha_2_code      :string
#  alpha_3_code      :string
#  numeric_code      :string
#  flag              :string
#  latlng            :string
#  area              :decimal(, )
#  population        :decimal(, )
#  languages         :string
#  timezones         :string
#  currencies        :string
#  top_level_domains :string
#  calling_codes     :string
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
             :calling_codes

  attribute :country_code, &:alpha_2_code
end
