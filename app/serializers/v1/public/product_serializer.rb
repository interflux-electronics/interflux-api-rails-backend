module V1
  module Public
    class ProductSerializer < ApplicationSerializer
      attributes :slug,
                 :name,
                 :public,
                 :deprecated,
                 :orderable,
                 :popular,
                 :new

      belongs_to :product_family

      has_many :product_images
      has_many :product_variants
    end
  end
end
