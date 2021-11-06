class Webinar < ApplicationRecord
  belongs_to :person, optional: true
  belongs_to :image, optional: true
  belongs_to :video, optional: true
  belongs_to :document, optional: true

  has_many :webinar_invitees, dependent: :destroy
  has_many :webinar_attendees, dependent: :destroy
end
