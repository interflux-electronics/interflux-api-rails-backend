class ProductVariant < ApplicationRecord
  belongs_to :product
  belongs_to :container, optional: true
end
