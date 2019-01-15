module V1
  module Public
    class ProductSerializer < ApplicationSerializer
      include FastJsonapi::ObjectSerializer

      attributes :slug,
                 :name,
                 :pitch

      belongs_to :main_group, record_type: :product_group, serializer: :product_group
      belongs_to :sub_group, record_type: :product_group, serializer: :product_group

      has_many :related_products, record_type: :product, serializer: :related_products
      has_many :related_articles, record_type: :article, serializer: :related_articles

      has_many :translations, record_type: :product_translation, serializer: :product_translation
    end
  end
end
