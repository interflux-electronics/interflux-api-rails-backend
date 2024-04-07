module V1
  module Public
    class EventAttendeesController < ApplicationController
      def index
        forbidden
      end

      def show
        forbidden
      end

      def create
        allow_create
      end

      def update
        allow_update
      end

      def destroy
        forbidden
      end

      private

      def model_class
        EventAttendee
      end

      def serializer_class
        V1::Public::EventAttendeeSerializer
      end

      def creatable_attributes
        %i[
          first_name
          last_name
          role
          company
          email
        ]
      end

      def creatable_relationships
        %i[
          event
        ]
      end
    end
  end
end
