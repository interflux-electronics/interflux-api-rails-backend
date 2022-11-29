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
        allow_destroy
      end

      private

      def model_class
        Document
      end

      def serializer_class
        V1::Admin::DocumentSerializer
      end

      def permitted_filters
        %i[
          name
        ]
      end

      def permitted_includes
        %i[
          document_category
          cdn_files
          products
          product_documents
        ]
      end

      def creatable_attributes
        %i[
          path
          name
          public
        ]
      end

      def creatable_relationships
        %i[
          document_category
        ]
      end
    end
  end
end
