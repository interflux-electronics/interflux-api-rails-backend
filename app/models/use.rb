# == Schema Information
#
# Table name: uses
#
#  id         :uuid             not null, primary key
#  name       :string
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Use < ApplicationRecord
  has_many :product_uses
  has_many :products, through: :product_uses, source: :product
end
