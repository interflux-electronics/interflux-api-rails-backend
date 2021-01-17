module V1
  module Admin
    class ArticlesController < V1::AdminController
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
        forbidden
      end

      def destroy
        forbidden
      end

      private

      def model_class
        Article
      end

      def serializer_class
        V1::Admin::ArticleSerializer
      end

      def creatable_attributes
        %i[
          slug
          title
          body
        ]
      end
    end
  end
end
