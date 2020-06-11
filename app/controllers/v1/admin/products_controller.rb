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

      def resource_klass
        Product
      end

      def serializer_klass
        V1::Admin::ProductSerializer
      end

      def permitted_includes
        %i[
          image
          images
          documents
          documents.language
          product_family
          features
        ]
      end
    end
  end
end
