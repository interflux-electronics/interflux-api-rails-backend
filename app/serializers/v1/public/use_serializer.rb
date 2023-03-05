module V1
  module Public
    class UseSerializer < ApplicationSerializer
      attributes :slug,
                 :text,
                 :icon,
                 :gist,
                 :rank

      belongs_to :image

      has_many :products, if: requested?('products')
      has_many :product_uses, if: requested?('product_uses')
      has_many :use_images, if: requested?('use_images')

      cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 1.day
    end
  end
end
