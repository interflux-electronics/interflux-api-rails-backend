module V1
  module Public
    class ProductImageSerializer < ApplicationSerializer
      attributes :rank,
                 :public

      belongs_to :product
      belongs_to :image

      cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 1.day
    end
  end
end
