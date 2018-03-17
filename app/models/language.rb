# == Schema Information
#
# Table name: languages
#
#  id           :uuid             not null, primary key
#  locale       :string
#  name_english :string
#  name_native  :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Language < ApplicationRecord
  has_many :product_translations
  has_many :image_translations
end
