# == Schema Information
#
# Table name: product_images
#
#  id         :uuid             not null, primary key
#  public     :boolean
#  rank       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  image_id   :string
#  product_id :string
#
class ProductImage < ApplicationRecord
  belongs_to :product
  belongs_to :image
end
