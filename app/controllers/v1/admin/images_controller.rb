module V1
  module Admin
    class ImagesController < V1::AdminController
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

      def model_class
        Image
      end

      def serializer_class
        V1::Admin::ImageSerializer
      end

      def permitted_includes
        %i[
          products
          product_images
          people
          person_images
          company
          cdn_files
        ]
      end

      def permitted_filters
        %i[
          alt
          path
        ]
      end

      def creatable_attributes
        %i[
          alt
          caption
        ]
      end

      def creatable_relationships
        %i[
          company
        ]
      end
    end
  end
end
