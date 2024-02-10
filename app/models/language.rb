# == Schema Information
#
# Table name: languages
#
#  name_english      :string
#  name_native       :string
#  public            :boolean          default(FALSE)
#  three_letter_code :string
#  two_letter_code   :string           not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Language < ApplicationRecord
  has_many :country_languages, dependent: :destroy
  has_many :countries, through: :country_languages, source: :country
end
