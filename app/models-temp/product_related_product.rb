# == Schema Information
#
# Table name: product_related_products
#
#  id                 :uuid             not null, primary key
#  product_id         :uuid
#  related_product_id :uuid
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class ProductRelatedProduct < ApplicationRecord
  belongs_to :product
  belongs_to :related_product, class_name: 'Product'

  validates :product, presence: true
  validates :complement, presence: true
end
