module V1
  module Admin
    class ArticleCategoriesController < ApplicationController
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
        ArticleCategory
      end

      def serializer_class
        V1::Admin::ArticleCategorySerializer
      end
    end
  end
end
