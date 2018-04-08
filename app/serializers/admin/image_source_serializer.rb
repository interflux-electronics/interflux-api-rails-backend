module Admin
  class ImageSourceSerializer < ApplicationSerializer
    attributes :url,
               :width,
               :height

    belongs_to :product_image
  end
end
