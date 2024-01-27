module V1
  module Public
    class TranslationsController < V1::PublicController
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
          location
          language
        ]
      end

      def creatable_attributes
        %i[
          language
          location
          english
          english_before
          status
        ]
      end
    end
  end
end
