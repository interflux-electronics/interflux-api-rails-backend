# == Schema Information
#
# Table name: product_uses
#
#  id         :uuid             not null, primary key
#  product_id :uuid
#  use_id     :uuid
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ProductUse < ApplicationRecord
  belongs_to :product
  belongs_to :use
end
