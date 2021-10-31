module V1
  module Admin
    class WebinarsController < ApplicationController
      def index
        allow_index
      end

      def show
        allow_show
      end

      def create
        allow_create
      end

      def update
        allow_update
      end

      def destroy
        allow_destroy
      end

      private

      def model_class
        Webinar
      end

      def serializer_class
        V1::Admin::WebinarSerializer
      end

      def permitted_includes
        %i[
          person
          image
          video
          webinar_invitees
          webinar_invitees.person
          webinar_attendees
          webinar_attendees.person
        ]
      end

      def creatable_attributes
        %i[
          title
          topic
          audience
          url
          start_time
          duration
          public
        ]
      end

      def creatable_relationships
        %i[
          person
          image
          video
        ]
      end
    end
  end
end
