module V1
  module Admin
    class ProductUsesController < ApplicationController
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
        ProductUse
      end

      def serializer_class
        V1::Admin::ProductUseSerializer
      end

      def creatable_relationships
        %i[
          product
          use
        ]
      end

      def creatable_attributes
        %i[
          rank_among_products
          rank_among_uses
          show_on_product_list
        ]
      end
    end
  end
end
