# == Schema Information
#
# Table name: product_substitutes
#
#  id               :uuid             not null, primary key
#  product_serie_id :uuid
#  substitute_id    :uuid
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class ProductSubstitute < ApplicationRecord
  belongs_to :product_serie
  belongs_to :substitute, class_name: 'ProductSerie', foreign_key: 'substitute_id'
end
