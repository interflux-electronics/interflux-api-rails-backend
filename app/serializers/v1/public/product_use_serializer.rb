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

      cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 1.day
    end
  end
end
