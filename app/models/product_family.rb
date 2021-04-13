class ProductFamily < ApplicationRecord
  belongs_to :product_family, optional: true

  has_many :products

  has_many :product_family_images
  has_many :images, through: :product_family_images, source: :image
end
