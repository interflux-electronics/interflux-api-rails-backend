module V1
  module Admin
    class WebinarInviteesController < ApplicationController
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
        WebinarInvitee
      end

      def serializer_class
        V1::Admin::WebinarInviteeSerializer
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
