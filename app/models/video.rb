class Video < ApplicationRecord
  belongs_to :webinar, optional: true
end
