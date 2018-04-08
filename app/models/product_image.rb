# == Schema Information
#
# Table name: product_images
#
#  id         :uuid             not null, primary key
#  product_id :uuid
#  alt        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ProductImage < ApplicationRecord
  belongs_to :product
  has_many :image_sources
  has_many :image_translations

  # before_destroy :delete_sources
  # before_destroy :delete_translations
end
