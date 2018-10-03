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

class Feature < ApplicationRecord
  has_many :product_features
end
