module V1
  module Admin
    class ProductDocumentsController < V1::AdminController
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
        allow_destroy
      end

      private

      def model_class
        ProductDocument
      end

      def serializer_class
        V1::Admin::ProductDocumentSerializer
      end

      def creatable_relationships
        %i[
          document
          product
        ]
      end
    end
  end
end
