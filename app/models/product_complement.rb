# == Schema Information
#
# Table name: product_complements
#
#  id            :uuid             not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  complement_id :uuid
#  product_id    :uuid
#
# Indexes
#
#  index_product_complements_on_complement_id  (complement_id)
#  index_product_complements_on_product_id     (product_id)
#
class ProductComplement < ApplicationRecord
  belongs_to :product
  belongs_to :complement, class_name: 'Product', foreign_key: 'complement_id'
end
