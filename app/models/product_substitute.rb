# == Schema Information
#
# Table name: product_substitutes
#
#  id            :uuid             not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  product_id    :uuid
#  substitute_id :uuid
#
# Indexes
#
#  index_product_substitutes_on_product_id     (product_id)
#  index_product_substitutes_on_substitute_id  (substitute_id)
#
class ProductSubstitute < ApplicationRecord
  belongs_to :product
  belongs_to :substitute, class_name: 'Product', foreign_key: 'substitute_id'
end
