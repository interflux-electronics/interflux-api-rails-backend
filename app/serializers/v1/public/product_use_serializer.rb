module V1
  module Public
    class ProductUseSerializer < ApplicationSerializer
      attributes :rank_among_products,
                 :rank_among_uses,
                 :show_on_product_list,
                 :show_alternative_avatar

      belongs_to :product
      belongs_to :use
      belongs_to :image
    end
  end
end
