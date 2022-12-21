module V1
  module Admin
    class TranslationEventsController < ApplicationController
      def index
        allow_index
      end

      def show
        allow_show
      end

      def create
        forbidden
      end

      def update
        allow_update
      end

      def destroy
        forbidden
      end

      private

      def model_class
        TranslationEvent
      end

      def serializer_class
        V1::Admin::TranslationEventSerializer
      end

      def creatable_attributes
        %i[
          code
          updated_by
        ]
      end

      def creatable_relationships
        %i[
          translation
        ]
      end
    end
  end
end
