# == Schema Information
#
# Table name: images
#
#  id         :uuid             not null, primary key
#  url        :string
#  width      :integer
#  height     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Image < ApplicationRecord
  has_many :product_images
end
