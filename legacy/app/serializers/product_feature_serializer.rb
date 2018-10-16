# == Schema Information
#
# Table name: product_features
#
#  id         :uuid             not null, primary key
#  product_id :uuid
#  feature_id :uuid
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ProductFeatureSerializer < ApplicationSerializer
  belongs_to :product
  belongs_to :feature
end
