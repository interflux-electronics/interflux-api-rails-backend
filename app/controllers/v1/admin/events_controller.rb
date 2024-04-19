module V1
  module Admin
    class EventsController < ApplicationController
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
        Event
      end

      def serializer_class
        V1::Admin::EventSerializer
      end

      def creatable_attributes
        %i[
          name
          city
          dates
          start_date
          end_date
          description
          has_registration_form
          ask_first_name
          ask_last_name
          ask_role
          ask_company
          confirmation_email_subject
          confirmation_email_body
          confirmation_email_bcc
          website
        ]
      end

      def creatable_relationships
        %i[
          country
        ]
      end

      def permitted_includes
        %i[
          country
          permalinks
          event_attendees
        ]
      end
    end
  end
end
