module V1
  module Admin
    class WebinarAttendeeSerializer < ApplicationSerializer
      belongs_to :webinar
      belongs_to :person
    end
  end
end
