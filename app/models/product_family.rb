# == Schema Information
#
# Table name: product_families
#
#  slug        :string           not null, primary key
#  name_single :string
#  name_plural :string
#  public      :boolean          default(FALSE)
#  order       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  gist        :string
#

class ProductFamily < ApplicationRecord
  has_many :products

  has_many :product_family_images
  has_many :images, through: :product_family_images, source: :image
end
