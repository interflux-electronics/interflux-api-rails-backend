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

class ArticleCategory < ApplicationRecord
  has_many :articles
end
