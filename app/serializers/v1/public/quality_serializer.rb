module V1
  module Public
    class QualitySerializer < ApplicationSerializer
      attributes :slug,
                 :text,
                 :icon,
                 :gist

      has_many :products, if: requested?('products')
      has_many :product_qualities, if: requested?('product_qualities')

      cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 1.day
    end
  end
end
