class Country < ApplicationRecord
  has_many :country_languages, dependent: :destroy
  has_many :languages, through: :country_languages, source: :language

  has_many :country_currencies, dependent: :destroy
  has_many :currencies, through: :country_currencies, source: :currency

  has_many :company_markets, dependent: :destroy
  has_many :companies, through: :company_markets, source: :company
end
