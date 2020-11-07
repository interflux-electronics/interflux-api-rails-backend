module V1
  module Admin
    class UsesController < ApplicationController
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
        Use
      end

      def serializer_class
        V1::Admin::UseSerializer
      end

      def permitted_includes
        %i[
          products
          products.image
          products.product_family
          product_uses
        ]
      end
    end
  end
end
