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
        allow_destroy
      end

      private

      def model_class
        ProductImage
      end

      def serializer_class
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
