module V1
  module Admin
    class ProductTranslationsController < ApplicationController
      include JsonApi
      include Errors

      def index
        user_can_fetch_all true
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
        ProductTranslation
      end

      def serializer_klass
        V1::Public::ProductTranslationSerializer
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
          product
          product.related_articles
          product.related_products
          product.related_products.main_group
        ]
      end
    end
  end
end
