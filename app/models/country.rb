# == Schema Information
#
# Table name: countries
#
#  two_letter_code   :string           not null, primary key
#  name_english      :string
#  name_native       :string
#  three_letter_code :string
#  numeric_code      :string
#  region            :string
#  subregion         :string
#  latitude          :decimal(, )
#  longitude         :decimal(, )
#  area              :integer
#  population        :integer
#  flag_url          :string
#  timezones         :string
#  top_level_domains :string
#  calling_codes     :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Country < ApplicationRecord
  # Languages
  has_many :country_languages, class_name: 'CountryLanguage', dependent: :destroy
  has_many :languages, through: :country_languages, source: :language

  # Currencies
  has_many :country_currencies, class_name: 'CountryCurrency', dependent: :destroy
  has_many :currencies, through: :country_currencies, source: :currency
end
