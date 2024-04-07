module V1
  module Admin
    class EventAttendeeSerializer < ApplicationSerializer
      attributes :first_name,
                 :last_name,
                 :role,
                 :company,
                 :email

      belongs_to :event
      belongs_to :person
    end
  end
end
