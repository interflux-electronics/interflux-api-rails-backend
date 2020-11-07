class Quality < ApplicationRecord
  has_many :product_qualities, dependent: :destroy
  has_many :products, through: :product_qualities, source: :product
end
