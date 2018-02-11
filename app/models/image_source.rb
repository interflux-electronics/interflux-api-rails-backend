# == Schema Information
#
# Table name: image_sources
#
#  id         :integer          not null, primary key
#  url        :string
#  width      :integer
#  height     :integer
#  image_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ImageSource < ApplicationRecord
  belongs_to :image
end
