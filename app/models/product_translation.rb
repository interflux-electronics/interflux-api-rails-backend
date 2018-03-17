# == Schema Information
#
# Table name: product_translations
#
#  id          :uuid             not null, primary key
#  body        :text
#  pitch       :text
#  product_id  :uuid
#  language_id :uuid
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ProductTranslation < ApplicationRecord
  belongs_to :product
  belongs_to :language
end
