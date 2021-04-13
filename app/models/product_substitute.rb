class ProductSubstitute < ApplicationRecord
  belongs_to :product
  belongs_to :substitute, class_name: 'Product', foreign_key: 'substitute_id'
end
