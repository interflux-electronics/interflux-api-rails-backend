# == Schema Information
#
# Table name: features
#
#  id         :uuid             not null, primary key
#  label      :string
#  icon       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class FeatureSerializer < ApplicationSerializer
  attributes :label,
             :icon

  has_many :product_feature
end
