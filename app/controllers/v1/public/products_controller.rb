module V1
  module Public
    class ProductsController < ApplicationController
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
        Product
      end

      def serializer_class
        V1::Public::ProductSerializer
      end

      def permitted_filters
        %i[
          name
          deprecated
          popular
          on_front_page
        ]
      end

      def permanent_filters
        {
          public: true
        }
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
          product_uses.image
        ]
      end
    end
  end
end
