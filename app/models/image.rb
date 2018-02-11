# == Schema Information
#
# Table name: images
#
#  id         :integer          not null, primary key
#  caption    :string
#  product_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Image < ApplicationRecord
  belongs_to :product, optional: true
  has_many :image_sources
  has_many :image_translations
end
