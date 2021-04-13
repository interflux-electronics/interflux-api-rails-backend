class Country < ApplicationRecord
  # Languages
  has_many :country_languages, class_name: 'CountryLanguage', dependent: :destroy
  has_many :languages, through: :country_languages, source: :language

  # Currencies
  has_many :country_currencies, class_name: 'CountryCurrency', dependent: :destroy
  has_many :currencies, through: :country_currencies, source: :currency

  has_many :company_markets, dependent: :destroy
  has_many :companies, through: :company_markets, source: :company
end
