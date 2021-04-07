module V1
  module Admin
    class ProductsController < V1::AdminController
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
        Product
      end

      def serializer_class
        V1::Admin::ProductSerializer
      end

      def permitted_filters
        %i[
          name
        ]
      end

      def permitted_includes
        %i[
          image
          images
          documents
          documents.language
          qualities
          uses
          product_images.image
          product_family
          product_images
          product_documents
          product_qualities
          product_uses
        ]
      end

      def creatable_attributes
        %i[
          slug
          name
          label
          status
          pitch
          summary
          properties
          instructions
          rank_among_family
          complies_with_iso
          complies_with_rohs
          complies_with_iec
          complies_with_ipcjstd004_a
          complies_with_ipcjstd004_b
          complies_with_ipcjstd005
          test_results
        ]
      end

      def creatable_relationships
        %i[
          image
          product_family
          superior_product
        ]
      end
    end
  end
end
