class Feature < ApplicationRecord
  has_many :product_features, dependent: :destroy
  has_many :products, through: :product_features, source: :product
end
