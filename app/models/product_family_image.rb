class ProductFamilyImage < ApplicationRecord
  belongs_to :product_family
  belongs_to :image
end
