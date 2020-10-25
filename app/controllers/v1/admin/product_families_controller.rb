module V1
  module Admin
    class ProductFamiliesController < V1::AdminController
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
        ProductFamily
      end

      def serializer_klass
        V1::Admin::ProductFamilySerializer
      end

      def permitted_includes
        %i[
          products
          products.image
          products.features
        ]
      end

      def permitted_filters
        %i[
          name_single
          name_plural
        ]
      end

      def creatable_attributes
        %i[
          name_single
          name_plural
          order
        ]
      end
    end
  end
end
