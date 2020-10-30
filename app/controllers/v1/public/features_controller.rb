module V1
  module Public
    class FeaturesController < ApplicationController
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
        Feature
      end

      def serializer_class
        V1::Public::FeatureSerializer
      end

      def permitted_filters
        %i[
          category
        ]
      end

      def permitted_includes
        %i[
          products
          products.image
        ]
      end
    end
  end
end
