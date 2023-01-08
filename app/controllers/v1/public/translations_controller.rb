module V1
  module Public
    class TranslationsController < ApplicationController
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
        forbidden
      end

      def destroy
        forbidden
      end

      private

      def model_class
        Translation
      end

      def serializer_class
        V1::Public::TranslationSerializer
      end

      def permitted_filters
        %i[
          key
          language
        ]
      end

      def creatable_attributes
        %i[
          key
          language
          english
        ]
      end
    end
  end
end
