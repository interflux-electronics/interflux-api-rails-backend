module V1
  module Admin
    class ProductFamilySerializer < ApplicationSerializer
      attributes :slug,
                 :name_single,
                 :name_plural,
                 :gist,
                 :the_full_monty,
                 :rank,
                 :public

      belongs_to :product_family

      has_many :products, if: requested?('products')
      has_many :product_family_images, if: requested?('product_family_images')
    end
  end
end
