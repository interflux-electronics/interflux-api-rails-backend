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
          description
        ]
      end

      def creatable_relationships
        %i[
          country
        ]
      end
    end
  end
end
