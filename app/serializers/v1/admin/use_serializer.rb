module V1
  module Admin
    class UseSerializer < ApplicationSerializer
      attributes :slug,
                 :text,
                 :icon,
                 :gist

      has_many :products, if: requested?('products')
      has_many :product_uses, if: requested?('product_uses')
    end
  end
end
