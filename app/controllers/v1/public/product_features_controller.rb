module V1
  module Public
    class ProductFeaturesController < ApplicationController
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
        ProductFeature
      end

      def serializer_class
        V1::Public::ProductFeatureSerializer
      end
    end
  end
end
