module V1
  module Admin
    class WebinarAttendeesController < ApplicationController
      def index
        allow_index
      end

      def show
        allow_show
      end

      # Can only be created on Public by owner.
      def create
        forbidden
      end

      # Can only be updated on Public by owner.
      def update
        forbidden
      end

      # Can only be deleted on Public by owner.
      def destroy
        forbidden
      end

      private

      def model_class
        WebinarAttendee
      end

      def serializer_class
        V1::Admin::WebinarAttendeeSerializer
      end
    end
  end
end
