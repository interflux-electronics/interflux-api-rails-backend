class ProductVideo < ApplicationRecord
  belongs_to :product
  belongs_to :video
end
