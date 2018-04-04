module Admin
  class ImageSourceSerializer < ApplicationSerializer
    attributes :url,
               :width,
               :height
               
    belongs_to :image
  end
end
