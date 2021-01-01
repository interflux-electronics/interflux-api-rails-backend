module V1
  module Public
    class UseSerializer < ApplicationSerializer
      attributes :slug,
                 :text,
                 :icon,
                 :gist

      belongs_to :image

      has_many :products, if: requested?('products')
      has_many :product_uses, if: requested?('product_uses')
    end
  end
end
