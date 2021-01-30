# == Schema Information
#
# Table name: webinar_invitees
#
#  id         :uuid             not null, primary key
#  webinar_id :uuid
#  person_id  :uuid
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class WebinarInvitee < ApplicationRecord
  belongs_to :webinar
  belongs_to :person
end
