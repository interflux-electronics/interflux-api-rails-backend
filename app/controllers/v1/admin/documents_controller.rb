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

      def resource_klass
        Document
      end

      def serializer_klass
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
