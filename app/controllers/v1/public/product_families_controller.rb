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

      def resource_klass
        ProductFamily
      end

      def serializer_klass
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
