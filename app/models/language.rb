# == Schema Information
#
# Table name: languages
#
#  id           :integer          not null, primary key
#  locale       :string
#  name_english :string
#  name_native  :string
#

class Language < ApplicationRecord
  has_many :product_translations
  has_many :image_translations
end
