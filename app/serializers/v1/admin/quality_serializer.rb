module V1
  module Admin
    class QualitySerializer < ApplicationSerializer
      attributes :slug,
                 :text,
                 :icon,
                 :gist

      belongs_to :image

      has_many :products, if: requested?('products')
      has_many :product_qualities, if: requested?('product_qualities')
    end
  end
end
