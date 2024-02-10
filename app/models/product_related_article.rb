# == Schema Information
#
# Table name: product_related_articles
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  article_id :uuid
#  product_id :uuid
#
# Indexes
#
#  index_product_related_articles_on_article_id  (article_id)
#  index_product_related_articles_on_product_id  (product_id)
#
class ProductRelatedArticle < ApplicationRecord
  belongs_to :product
  belongs_to :article
end
