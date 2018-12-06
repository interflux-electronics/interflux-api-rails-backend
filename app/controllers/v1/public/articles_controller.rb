module V1
  module Public
    class ArticlesController < ApplicationController
      include JsonApi
      include Errors

      def index
        user_can_fetch_all
      end

      def show
        user_can_fetch_one_by_id_or_slug
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
        Article
      end

      def serializer_klass
        V1::Public::ArticleSerializer
      end

      def creatable_attributes
        %i[]
      end

      def creatable_relationships
        %i[]
      end

      def permitted_filters
        %i[]
      end

      def permitted_includes
        %i[
          author
          author.person
        ]
      end
    end
  end
end
