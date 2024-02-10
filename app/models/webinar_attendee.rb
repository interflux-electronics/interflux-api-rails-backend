# == Schema Information
#
# Table name: webinar_attendees
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  person_id  :uuid
#  webinar_id :uuid
#
class WebinarAttendee < ApplicationRecord
  belongs_to :webinar
  belongs_to :person
end
