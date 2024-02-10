# == Schema Information
#
# Table name: article_categories
#
#  id         :uuid             not null, primary key
#  name       :string
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_article_categories_on_name  (name) UNIQUE
#  index_article_categories_on_slug  (slug) UNIQUE
#
class ArticleCategory < ApplicationRecord
  has_many :articles
end
