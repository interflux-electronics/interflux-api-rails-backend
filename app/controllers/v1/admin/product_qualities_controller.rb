module V1
  module Admin
    class ProductQualitiesController < ApplicationController
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
        ProductQuality
      end

      def serializer_class
        V1::Admin::ProductQualitySerializer
      end

      def creatable_relationships
        %i[
          product
          quality
        ]
      end
    end
  end
end
