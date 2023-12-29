module V1
  module Admin
    class VideoSerializer < ApplicationSerializer
      attributes :path,
                 :variations,
                 :title,
                 :notes

      has_many :product_videos, if: requested?('product_videos')
      has_many :products, if: requested?('products')
    end
  end
end
