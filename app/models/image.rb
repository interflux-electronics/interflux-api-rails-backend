# == Schema Information
#
# Table name: images
#
#  id               :uuid             not null, primary key
#  image_owner_id   :uuid
#  image_owner_type :string
#  alt              :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Image < ApplicationRecord
  belongs_to :image_owner, polymorphic: true

  has_many :image_sources
  has_many :image_translations

  scope :for_products, -> { where(image_owner_type: 'Product') }
  scope :for_owner, ->(id) { where(image_owner_id: id) }
end
