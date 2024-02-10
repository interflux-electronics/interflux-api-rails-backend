# == Schema Information
#
# Table name: features
#
#  category   :string
#  gist       :string
#  has_page   :boolean
#  icon       :string
#  slug       :string           not null, primary key
#  text       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Feature < ApplicationRecord
  has_many :product_features, dependent: :destroy
  has_many :products, through: :product_features, source: :product
end
