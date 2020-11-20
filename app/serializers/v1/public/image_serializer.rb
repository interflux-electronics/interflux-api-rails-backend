module V1
  module Public
    class ImageSerializer < ApplicationSerializer
      attributes :path,
                 :alt,
                 :caption,
                 :variations

      belongs_to :company

      has_many :products, if: requested?('products')
      has_many :product_images, if: requested?('product_images')
      has_many :cdn_files, if: requested?('cdn_files')
    end
  end
end
