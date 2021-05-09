module V1
  module Admin
    class ProductUseSerializer < ApplicationSerializer
      attributes :rank_among_products,
                 :rank_among_uses,
                 :show_on_product_list

      belongs_to :product
      belongs_to :use
    end
  end
end
