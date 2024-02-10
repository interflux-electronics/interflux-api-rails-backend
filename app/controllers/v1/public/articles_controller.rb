module V1
  module Public
    class ArticlesController < V1::PublicController
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
        Article
      end

      def serializer_class
        V1::Public::ArticleSerializer
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
