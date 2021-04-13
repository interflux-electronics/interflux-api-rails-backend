class ProductQuality < ApplicationRecord
  belongs_to :product
  belongs_to :quality
end
