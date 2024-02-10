# == Schema Information
#
# Table name: webinar_videos
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  video_id   :uuid
#  webinar_id :uuid
#
class WebinarVideo < ApplicationRecord
  belongs_to :webinar
  belongs_to :video
end
