# == Schema Information
#
# Table name: qualities
#
#  slug       :string           not null, primary key
#  text       :string
#  icon       :string
#  gist       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Quality < ApplicationRecord
  has_many :product_qualities, dependent: :destroy
  has_many :products, through: :product_qualities, source: :product
end
