module V1
  module Public
    class PersonImagesController < V1::PublicController
      def index
        forbidden
      end

      def show
        forbidden
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
        PersonImage
      end

      def serializer_class
        V1::Public::PersonImageSerializer
      end
    end
  end
end
