module V1
  module Public
    class LanguagesController < V1::PublicController
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
        Language
      end

      def serializer_class
        V1::Public::LanguageSerializer
      end

      def permanent_filters
        {
          public: true
        }
      end
    end
  end
end
