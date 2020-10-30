module V1
  module Public
    class ProductFamiliesController < ApplicationController
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
        ProductFamily
      end

      def serializer_class
        V1::Public::ProductFamilySerializer
      end

      def permanent_filters
        {
          public: true
        }
      end

      def permitted_includes
        %i[
          products
          products.image
          products.features
        ]
      end
    end
  end
end
