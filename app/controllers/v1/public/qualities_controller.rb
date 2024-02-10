module V1
  module Public
    class QualitiesController < V1::PublicController
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
        Quality
      end

      def serializer_class
        V1::Public::QualitySerializer
      end
    end
  end
end
