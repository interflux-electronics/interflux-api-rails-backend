module V1
  module Public
    class ProductSerializer < ApplicationSerializer
      attributes :slug,
                 :name,
                 :public

      belongs_to :product_family

      has_many :documents, if: Proc.new { |record, params|
        params && params['include'] && params['include'].split(',').include?('documents')
      }

      has_many :images, if: Proc.new { |record, params|
        params && params['include'] && params['include'].split(',').include?('images')
      }

      # belongs_to :thing
      # belongs_to :main_group, record_type: :product_group, serializer: :product_group
      # belongs_to :sub_group, record_type: :product_group, serializer: :product_group

      # has_many :related_products, record_type: :product, serializer: :related_products
      # has_many :related_articles, record_type: :article, serializer: :related_articles
    end
  end
end

# module V1
#   module Public
#     class ProductSerializer < ApplicationSerializer
#       attributes :slug,
#                  :name,
#                  :public,
#                  :deprecated,
#                  :orderable,
#                  :popular,
#                  :new
#
#       belongs_to :product_family
#
#       has_many :images
#       has_many :variants
#       has_many :features
#     end
#   end
# end
