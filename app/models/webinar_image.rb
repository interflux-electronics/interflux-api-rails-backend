# == Schema Information
#
# Table name: webinar_images
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  image_id   :uuid
#  webinar_id :uuid
#
class WebinarImage < ApplicationRecord
  belongs_to :webinar
  belongs_to :image
end
