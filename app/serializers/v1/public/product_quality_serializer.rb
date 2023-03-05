module V1
  module Public
    class ProductQualitySerializer < ApplicationSerializer
      attributes :rank_among_products,
                 :rank_among_qualities,
                 :show_on_product_list

      belongs_to :product
      belongs_to :quality

      cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 1.day
    end
  end
end
