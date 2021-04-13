class ProductComplement < ApplicationRecord
  belongs_to :product
  belongs_to :complement, class_name: 'Product', foreign_key: 'complement_id'
end
