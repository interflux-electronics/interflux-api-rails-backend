class Use < ApplicationRecord
  has_many :product_uses, dependent: :destroy
  has_many :products, through: :product_uses, source: :product
end
