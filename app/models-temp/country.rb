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

class Country < ApplicationRecord
  alias_attribute :country_code, :alpha_2_code
end
