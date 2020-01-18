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

      has_many :images
      has_many :variants
      has_many :features
    end
  end
end
