# == Schema Information
#
# Table name: image_sources
#
#  id         :uuid             not null, primary key
#  url        :string
#  width      :integer
#  height     :integer
#  image_id   :uuid
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ImageSource < ApplicationRecord
  belongs_to :image
end
