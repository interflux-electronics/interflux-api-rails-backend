# == Schema Information
#
# Table name: product_qualities
#
#  id         :uuid             not null, primary key
#  product_id :string
#  quality_id :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  rank       :integer
#

class ProductQuality < ApplicationRecord
  belongs_to :product
  belongs_to :quality
end
