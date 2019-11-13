module V1
  module Public
    class ArticleSerializer < ApplicationSerializer
      attributes :slug,
                 :title,
                 :body,
                 :created_at,
                 :updated_at

      # belongs_to :thing
      # belongs_to :main_group, record_type: :product_group, serializer: :product_group
      # belongs_to :sub_group, record_type: :product_group, serializer: :product_group

      # has_many :things
      # has_many :related_products, record_type: :product, serializer: :related_products
      # has_many :related_articles, record_type: :article, serializer: :related_articles
    end
  end
end
