# == Schema Information
#
# Table name: product_uses
#
#  id                  :uuid             not null, primary key
#  product_id          :string
#  use_id              :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  rank_among_products :integer
#  rank_among_uses     :integer
#

class ProductUse < ApplicationRecord
  belongs_to :product
  belongs_to :use
end
