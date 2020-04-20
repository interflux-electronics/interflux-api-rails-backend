# == Schema Information
#
# Table name: features
#
#  id         :uuid             not null, primary key
#  slug       :string
#  text       :string
#  icon       :string
#  gist       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  category   :string
#

class Feature < ApplicationRecord
  has_many :product_features
  has_many :products, through: :product_features, source: :product
end
