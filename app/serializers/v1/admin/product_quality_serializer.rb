module V1
  module Admin
    class ProductQualitySerializer < ApplicationSerializer
      attributes :rank_among_products,
                 :rank_among_qualities,
                 :show_on_product_list

      belongs_to :product
      belongs_to :quality
    end
  end
end
