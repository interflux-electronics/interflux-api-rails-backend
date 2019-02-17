# == Schema Information
#
# Table name: product_substitutes
#
#  id            :uuid             not null, primary key
#  product_id    :uuid
#  substitute_id :uuid
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class ProductSubstitute < ApplicationRecord
  belongs_to :product
  belongs_to :substitute, class_name: 'Product', foreign_key: 'substitute_id'
end
