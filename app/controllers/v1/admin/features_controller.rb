module V1
  module Admin
    class FeaturesController < V1::AdminController
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
        forbidden
      end

      private

      def resource_klass
        Feature
      end

      def serializer_klass
        V1::Admin::FeatureSerializer
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
