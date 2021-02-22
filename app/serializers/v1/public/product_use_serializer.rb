module V1
  module Public
    class ProductUseSerializer < ApplicationSerializer
      attributes :rank_among_products,
                 :rank_among_uses

      belongs_to :product
      belongs_to :use
    end
  end
end
