# == Schema Information
#
# Table name: countries
#
#  area              :integer
#  calling_codes     :string
#  flag_url          :string
#  latitude          :decimal(, )
#  longitude         :decimal(, )
#  name_english      :string
#  name_native       :string
#  numeric_code      :string
#  population        :integer
#  region            :string
#  subregion         :string
#  three_letter_code :string
#  timezones         :string
#  top_level_domains :string
#  two_letter_code   :string           not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Country < ApplicationRecord
  has_many :country_languages, dependent: :destroy
  has_many :languages, through: :country_languages, source: :language

  has_many :country_currencies, dependent: :destroy
  has_many :currencies, through: :country_currencies, source: :currency

  has_many :company_markets, dependent: :destroy
  has_many :companies, through: :company_markets, source: :company
end
