module V1
  module Admin
    class ProductVideosController < V1::AdminController
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
        allow_destroy
      end

      private

      def model_class
        ProductVideo
      end

      def serializer_class
        V1::Admin::ProductVideoSerializer
      end

      def creatable_attributes
        %i[
          rank
          public
        ]
      end

      def creatable_relationships
        %i[
          product
          video
        ]
      end
    end
  end
end
