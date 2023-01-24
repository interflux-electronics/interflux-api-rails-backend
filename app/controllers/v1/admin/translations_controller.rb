module V1
  module Admin
    class TranslationsController < ApplicationController
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
        Translation
      end

      def serializer_class
        V1::Admin::TranslationSerializer
      end

      def permitted_includes
        %i[
          translation_events
        ]
      end

      def creatable_attributes
        %i[
          location
          language
          native
          english
          needs_review
          review_code
          custom_review_message
        ]
      end

      def permitted_filters
        %i[
          location
          language
        ]
      end
    end
  end
end
