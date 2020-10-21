# == Schema Information
#
# Table name: images
#
#  path       :string           not null, primary key
#  sizes      :string
#  formats    :string
#  caption    :string
#  alt        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Image < ApplicationRecord
  has_many :products
  # has_many :product_images
  # has_many :images, through: :product_images, source: :image
end
