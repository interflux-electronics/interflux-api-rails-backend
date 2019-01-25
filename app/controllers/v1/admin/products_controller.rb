module V1
  module Admin
    class ProductsController < ApplicationController
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
        Product
      end

      def serializer_klass
        V1::Public::ProductSerializer
      end

      def creatable_attributes
        %i[]
      end

      def creatable_relationships
        %i[]
      end

      def permitted_filters
        %i[
          main_group_id
          sub_group_id
        ]
      end

      def permanent_filters
        {
          public: true
        }
      end

      def permitted_includes
        %i[
          related_articles
          related_products
          related_products.main_group
          translations
        ]
      end
    end
  end
end
