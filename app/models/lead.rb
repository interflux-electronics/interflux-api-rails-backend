# == Schema Information
#
# Table name: leads
#
#  id            :uuid             not null, primary key
#  company       :string
#  email         :string
#  ip            :string
#  ip_city       :string
#  ip_region     :string
#  message       :text
#  mobile        :string
#  name          :string
#  purpose       :string
#  source        :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  country_id    :uuid
#  ip_country_id :uuid
#
# Indexes
#
#  index_leads_on_country_id     (country_id)
#  index_leads_on_ip_country_id  (ip_country_id)
#
class Lead < ApplicationRecord
  # Relate to a model
  # belongs_to :company
  # belongs_to :main_group, class_name: 'ProductGroup', foreign_key: 'main_group_id'
  # belongs_to :sub_group, class_name: 'ProductGroup', foreign_key: 'sub_group_id'

  # Relate to many of another model
  # Requires intermediary model ProductRelatedArticle
  # has_many :related_articles_association, class_name: 'ProductRelatedArticle'
  # has_many :related_articles, through: :related_articles_association, source: :article

  # Relate to many of same model
  # Requires intermediary model ProductRelatedProduct
  # has_many :related_products_association, class_name: 'ProductRelatedProduct'
  # has_many :related_products, through: :related_products_association, source: :related_product
  # has_many :inverse_related_products_association, class_name: 'ProductRelatedProduct', foreign_key: 'related_product_id'
  # has_many :inverse_related_products, through: :inverse_related_products_association, source: :product

  # validates :name, presence: true, uniqueness: true
end
