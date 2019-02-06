# == Schema Information
#
# Table name: country_languages
#
#  id          :uuid             not null, primary key
#  country_id  :uuid
#  language_id :uuid
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class CountryLanguage < ApplicationRecord
  belongs_to :country
  belongs_to :language
end
