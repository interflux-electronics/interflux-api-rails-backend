# == Schema Information
#
# Table name: product_qualities
#
#  id                   :uuid             not null, primary key
#  rank                 :integer
#  rank_among_products  :integer
#  rank_among_qualities :integer
#  show_on_product_list :boolean
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  product_id           :string
#  quality_id           :string
#
class ProductQuality < ApplicationRecord
  belongs_to :product
  belongs_to :quality
end
