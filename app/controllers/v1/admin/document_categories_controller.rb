module V1
  module Admin
    class DocumentCategoriesController < V1::AdminController
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
        DocumentCategory
      end

      def serializer_class
        V1::Admin::DocumentCategorySerializer
      end

      def permitted_filters
        %i[
          name
        ]
      end
    end
  end
end
