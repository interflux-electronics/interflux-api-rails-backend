module V1
  module Admin
    class ImageSerializer < ApplicationSerializer
      attributes :path,
                 :sizes,
                 :formats,
                 :alt,
                 :caption

      has_many :products, if: Proc.new { |record, params|
        params && params['include'] && params['include'].split(',').include?('products')
      }

      # belongs_to :thing
      # belongs_to :main_group, record_type: :product_group, serializer: :product_group
      # belongs_to :sub_group, record_type: :product_group, serializer: :product_group

      # has_many :things
      # has_many :related_products, record_type: :product, serializer: :related_products
      # has_many :related_articles, record_type: :article, serializer: :related_articles
    end
  end
end
