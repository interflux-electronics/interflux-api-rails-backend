module Admin
  class ImageTranslationSerializer < ApplicationSerializer
    attributes :alt
    belongs_to :product_image
    belongs_to :language
  end
end
