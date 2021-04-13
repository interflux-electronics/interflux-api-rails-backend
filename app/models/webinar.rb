class Webinar < ApplicationRecord
  belongs_to :person, optional: true

  has_many :webinar_invitees, dependent: :destroy
  has_many :invitees, through: :webinar_invitees, source: :person
end
