# == Schema Information
#
# Table name: product_complements
#
#  id            :uuid             not null, primary key
#  product_id    :uuid
#  complement_id :uuid
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class ProductComplement < ApplicationRecord
  belongs_to :product
  belongs_to :complement, class_name: 'Product', foreign_key: 'complement_id'
end
