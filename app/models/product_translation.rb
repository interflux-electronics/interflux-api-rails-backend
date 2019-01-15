# == Schema Information
#
# Table name: product_translations
#
#  id          :bigint(8)        not null, primary key
#  slug        :string
#  name        :string
#  pitch       :string
#  product_id  :uuid
#  language_id :uuid
#

class ProductTranslation < ApplicationRecord
  belongs_to :product
  belongs_to :language
end
