class ProductFeature < ApplicationRecord
  belongs_to :product
  belongs_to :feature
end
