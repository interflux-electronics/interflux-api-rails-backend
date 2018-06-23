module Public
  class ProductSerializer < ApplicationSerializer
    attributes :name,
               :slug,
               :pitch,
               :body

    belongs_to :main_category, record_type: :product_category, serializer: :product_category
    belongs_to :sub_category, record_type: :product_category, serializer: :product_category

    has_many :product_images

    # has_many :product_image_sources, record_type: :image_source, serializer: :image_source
    # attribute :product_image_sources do |object|
    #   object.product_images.map(&:image_sources).flatten
    # end
  end
end
