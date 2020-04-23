# == Schema Information
#
# Table name: product_images
#
#  id         :uuid             not null, primary key
#  product_id :string
#  image_id   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ProductImage < ApplicationRecord
  belongs_to :product
  belongs_to :image
end
