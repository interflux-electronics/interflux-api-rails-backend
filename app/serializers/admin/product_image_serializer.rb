module Admin
  class ProductImageSerializer < ApplicationSerializer
    attributes :alt
    belongs_to :product
    # has_many :image_sources
    # has_many :image_translations
  end
end
