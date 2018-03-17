# == Schema Information
#
# Table name: product_categories
#
#  id                 :uuid             not null, primary key
#  slug               :string
#  name_plural        :string
#  name_single        :string
#  parent_category_id :uuid
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class ProductCategory < ApplicationRecord
  belongs_to :parent_category, class_name: 'ProductCategory', foreign_key: 'parent_category_id'

  has_many :products

  scope :parent_category, ->(slug) { where(parent_category: ProductCategory.where(slug: slug)) }
end
