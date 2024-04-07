# == Schema Information
#
# Table name: events
#
#  id                         :uuid             not null, primary key
#  ask_company                :boolean
#  ask_first_name             :boolean
#  ask_last_name              :boolean
#  ask_role                   :boolean
#  city                       :string
#  confirmation_email_bcc     :string           default("s.teliszewski@interflux.com, jw@interflux.au")
#  confirmation_email_body    :string           default("Hello {first_name} {last_name},    We look forward seeing you at {event_name} on {event_date} in {event_location}.    Best regards,    The Interflux Electronics team")
#  confirmation_email_subject :string           default("See you soon at {event_name}!")
#  dates                      :string
#  description                :string
#  end_date                   :string
#  has_registration_form      :boolean
#  name                       :string
#  start_date                 :string
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  country_id                 :string
#
class Event < ApplicationRecord
  belongs_to :country

  has_many :permalinks
  has_many :event_attendees

  alias_attribute :attendees, :event_attendees
end
