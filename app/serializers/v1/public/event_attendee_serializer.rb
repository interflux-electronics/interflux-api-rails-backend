module V1
  module Public
    class EventAttendeeSerializer < ApplicationSerializer
      attributes :first_name,
                 :last_name,
                 :role,
                 :company,
                 :email

      belongs_to :event
    end
  end
end
