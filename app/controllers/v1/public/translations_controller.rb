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
        forbidden
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
          locale
        ]
      end
    end
  end
end
