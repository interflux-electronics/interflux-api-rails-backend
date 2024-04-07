# == Schema Information
#
# Table name: event_attendees
#
#  id         :uuid             not null, primary key
#  company    :string
#  email      :string
#  first_name :string
#  last_name  :string
#  role       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :uuid
#  person_id  :uuid
#
class EventAttendee < ApplicationRecord
  belongs_to :event
  belongs_to :person, optional: true
end
