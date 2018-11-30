# == Schema Information
#
# Table name: articles
#
#  id         :uuid             not null, primary key
#  slug       :string
#  title      :string
#  tease      :string
#  author_id  :uuid
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Article < ApplicationRecord
  belongs_to :author

  has_many :product_suggestions, through: :article_product_suggestions
  has_many :article_product_suggestions

  validates :slug, presence: true, uniqueness: true
  validates :title, presence: true, uniqueness: true
end
