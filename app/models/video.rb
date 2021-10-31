class Video < ApplicationRecord
  has_many :webinar_videos, dependent: :destroy
  has_many :webinars, through: :webinar_videos, source: :webinar
end
