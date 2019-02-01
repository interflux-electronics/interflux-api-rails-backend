# == Schema Information
#
# Table name: article_related_articles
#
#  id                 :uuid             not null, primary key
#  article_id         :uuid
#  related_article_id :uuid
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class ArticleRelatedArticle < ApplicationRecord
  belongs_to :author

  has_many :product_suggestions, through: :article_product_suggestions
  has_many :article_product_suggestions

  validates :slug, presence: true, uniqueness: true
  validates :title, presence: true, uniqueness: true
end
