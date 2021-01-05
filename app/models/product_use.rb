# == Schema Information
#
# Table name: product_uses
#
#  id         :uuid             not null, primary key
#  product_id :string
#  use_id     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  rank       :integer
#

class ProductUse < ApplicationRecord
  belongs_to :product
  belongs_to :use
end
