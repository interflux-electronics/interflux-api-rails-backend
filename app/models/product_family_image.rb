# == Schema Information
#
# Table name: product_family_images
#
#  id                :uuid             not null, primary key
#  product_family_id :string
#  image_id          :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class ProductFamilyImage < ApplicationRecord
  belongs_to :product_family
  belongs_to :image
end