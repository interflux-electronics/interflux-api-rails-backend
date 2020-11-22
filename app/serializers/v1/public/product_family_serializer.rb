module V1
  module Public
    class ProductFamilySerializer < ApplicationSerializer
      attributes :slug,
                 :name_single,
                 :name_plural,
                 :order

      has_many :products, if: requested?('products')
    end
  end
end
