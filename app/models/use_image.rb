# == Schema Information
#
# Table name: use_images
#
#  id         :uuid             not null, primary key
#  use_id     :uuid
#  image_id   :uuid
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UseImage < ApplicationRecord
  belongs_to :use
  belongs_to :image
end
