module V1
  module Public
    class ProductFamilySerializer < ApplicationSerializer
      attributes :slug,
                 :name_single,
                 :name_plural,
                 :gist,
                 :order

      has_many :products, if: requested?('products')
      has_many :product_family_images, if: requested?('product_family_images')
    end
  end
end
