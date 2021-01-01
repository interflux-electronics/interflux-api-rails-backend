module V1
  module Admin
    class ProductSubstitutesController < V1::AdminController
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
        ProductSubstitute
      end

      def serializer_class
        V1::Admin::ProductSubstituteSerializer
      end
    end
  end
end
