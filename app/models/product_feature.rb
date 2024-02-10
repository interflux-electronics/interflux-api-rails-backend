# == Schema Information
#
# Table name: product_features
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  feature_id :string
#  product_id :string
#
class ProductFeature < ApplicationRecord
  belongs_to :product
  belongs_to :feature
end
