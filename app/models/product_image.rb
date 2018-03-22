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

class ProductImage < ApplicationRecord
  has_many :image_sources
  has_many :image_translations
end
