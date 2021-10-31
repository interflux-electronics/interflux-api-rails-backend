module V1
  module Public
    class WebinarAttendeesController < ApplicationController
      def index
        # TODO: only allow current user index
        allow_index
      end

      def show
        # TODO: only allow current user show
        allow_show
      end

      def create
        # TODO: only allow current user create
        allow_create
      end

      def update
        # TODO: only allow current user update
        allow_update
      end

      def destroy
        # TODO: only allow current user destroy
        allow_destroy
      end

      private

      def model_class
        WebinarAttendee
      end

      def serializer_class
        V1::Public::WebinarAttendeeSerializer
      end

      def creatable_relationships
        %i[
          webinar
          person
        ]
      end
    end
  end
end
