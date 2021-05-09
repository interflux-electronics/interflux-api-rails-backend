module V1
  module Public
    class ProductUseSerializer < ApplicationSerializer
      attributes :rank_among_products,
                 :rank_among_uses,
                 :show_on_product_list

      belongs_to :product
      belongs_to :use
    end
  end
end
