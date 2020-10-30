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
          product_family
          features
        ]
      end
    end
  end
end
