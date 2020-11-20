module V1
  module Public
    class QualitySerializer < ApplicationSerializer
      attributes :slug,
                 :text,
                 :icon,
                 :gist

      has_many :products, if: requested?('products')
      has_many :product_qualities, if: requested?('product_qualities')
    end
  end
end
