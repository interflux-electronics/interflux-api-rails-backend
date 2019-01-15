# == Schema Information
#
# Table name: languages
#
#  id           :bigint(8)        not null, primary key
#  slug         :string
#  name_english :string
#  name_native  :string
#

class Language < ApplicationRecord
  has_many :product_translations
end
