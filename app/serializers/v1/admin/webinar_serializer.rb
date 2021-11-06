module V1
  module Admin
    class WebinarSerializer < ApplicationSerializer
      attributes :title,
                 :topic,
                 :audience,
                 :url,
                 :start_time,
                 :duration,
                 :public

      belongs_to :image
      belongs_to :video
      belongs_to :person
      belongs_to :document

      has_many :webinar_invitees, if: requested?('webinar_invitees')
      has_many :webinar_attendees, if: requested?('webinar_invitees')
    end
  end
end
