# == Schema Information
#
# Table name: features
#
#  slug       :string           not null, primary key
#  text       :string
#  icon       :string
#  gist       :string
#  category   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  has_page   :boolean
#

class Feature < ApplicationRecord
  has_many :product_features, dependent: :destroy
  has_many :products, through: :product_features, source: :product
end
