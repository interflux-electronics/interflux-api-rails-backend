# == Schema Information
#
# Table name: products
#
#  id            :uuid             not null, primary key
#  slug          :string
#  name          :string
#  pitch         :string
#  public        :boolean          default(FALSE)
#  main_group_id :uuid
#  sub_group_id  :uuid
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Product < ApplicationRecord
  belongs_to :main_group, class_name: 'ProductGroup', foreign_key: 'main_group_id'
  belongs_to :sub_group, class_name: 'ProductGroup', foreign_key: 'sub_group_id'

  has_many :related_products_association, class_name: 'ProductRelatedProduct'
  has_many :related_products, through: :related_products_association, source: :related_product
  has_many :inverse_related_products_association, class_name: 'ProductRelatedProduct', foreign_key: 'related_product_id'
  has_many :inverse_related_products, through: :inverse_related_products_association, source: :product

  has_many :related_articles_association, class_name: 'ProductRelatedArticle'
  has_many :related_articles, through: :related_articles_association, source: :article

  validates :slug, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true
end
