module V1
  module Admin
    class ProductImagesController < V1::AdminController
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
        allow_delete
      end

      private

      def resource_klass
        ProductImage
      end

      def serializer_klass
        V1::Admin::ProductImageSerializer
      end

      def creatable_attributes
        %i[
          rank
          public
        ]
      end

      def creatable_relationships
        %i[
          product
          image
        ]
      end
    end
  end
end
