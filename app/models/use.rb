# == Schema Information
#
# Table name: uses
#
#  slug       :string           not null, primary key
#  text       :string
#  icon       :string
#  gist       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Use < ApplicationRecord
  has_many :product_uses, dependent: :destroy
  has_many :products, through: :product_uses, source: :product
end
