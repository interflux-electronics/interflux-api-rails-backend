# == Schema Information
#
# Table name: image_translations
#
#  id               :uuid             not null, primary key
#  alt              :string
#  product_image_id :uuid
#  language_id      :uuid
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class ImageTranslation < ApplicationRecord
  belongs_to :product_image
  belongs_to :language
end
