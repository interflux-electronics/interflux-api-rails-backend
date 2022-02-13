class Language < ApplicationRecord
  has_many :country_languages, dependent: :destroy
  has_many :countries, through: :country_languages, source: :country
end
