module V1
  module Admin
    class DocumentsController < V1::AdminController
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
        Document
      end

      def serializer_class
        V1::Admin::DocumentSerializer
      end

      def permitted_includes
        %i[
          products
        ]
      end
    end
  end
end
