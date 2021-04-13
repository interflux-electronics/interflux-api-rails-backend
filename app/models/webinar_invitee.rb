class WebinarInvitee < ApplicationRecord
  belongs_to :webinar
  belongs_to :person
end
