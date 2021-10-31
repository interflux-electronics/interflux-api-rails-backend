class WebinarVideo < ApplicationRecord
  belongs_to :webinar
  belongs_to :video
end
