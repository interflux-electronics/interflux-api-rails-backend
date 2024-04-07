module V1
  module Admin
    class EventSerializer < ApplicationSerializer
      attributes :name,
                 :city,
                 :dates,
                 :start_date,
                 :end_date,
                 :description,
                 :has_registration_form,
                 :ask_first_name,
                 :ask_last_name,
                 :ask_role,
                 :ask_company,
                 :confirmation_email_subject,
                 :confirmation_email_body,
                 :confirmation_email_bcc

      belongs_to :country

      has_many :event_attendees
      has_many :permalinks
    end
  end
end
