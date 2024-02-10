# == Schema Information
#
# Table name: product_family_images
#
#  id                  :uuid             not null, primary key
#  rank_among_families :integer
#  rank_among_images   :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  image_id            :string
#  product_family_id   :string
#
class ProductFamilyImage < ApplicationRecord
  belongs_to :product_family
  belongs_to :image
end
