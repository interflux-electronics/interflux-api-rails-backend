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

      def resource_klass
        Feature
      end

      def serializer_klass
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
