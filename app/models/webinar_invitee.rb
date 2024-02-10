# == Schema Information
#
# Table name: webinar_invitees
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  person_id  :uuid
#  webinar_id :uuid
#
class WebinarInvitee < ApplicationRecord
  belongs_to :webinar
  belongs_to :person
end
