# == Schema Information
#
# Table name: product_features
#
#  id         :uuid             not null, primary key
#  product_id :string
#  feature_id :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ProductFeature < ApplicationRecord
  belongs_to :product
  belongs_to :feature
end
