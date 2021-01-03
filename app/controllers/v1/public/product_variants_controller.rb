module V1
  module Public
    class ProductVariantsController < ApplicationController
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
        ProductVariant
      end

      def serializer_class
        V1::Public::ProductVariantSerializer
      end
    end
  end
end
