# == Schema Information
#
# Table name: product_family_images
#
#  id                :uuid             not null, primary key
#  product_family_id :uuid
#  image_id          :uuid
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class ProductFamilyImage < ApplicationRecord
  belongs_to :product_family
  belongs_to :image
end
