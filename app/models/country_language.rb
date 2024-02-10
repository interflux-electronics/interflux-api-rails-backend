# == Schema Information
#
# Table name: country_languages
#
#  id          :uuid             not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  country_id  :string
#  language_id :string
#
# Indexes
#
#  index_country_languages_on_country_id   (country_id)
#  index_country_languages_on_language_id  (language_id)
#
class CountryLanguage < ApplicationRecord
  belongs_to :country
  belongs_to :language
end
