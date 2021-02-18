module V1
  module Admin
    class ProductFamilyImagesController < ApplicationController
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
        ProductFamilyImage
      end

      def serializer_class
        V1::Admin::ProductFamilyImageSerializer
      end

      def creatable_relationships
        %i[
          product_family
          image
        ]
      end

      def creatable_attributes
        %i[
          rank_among_families
          rank_among_images
        ]
      end
    end
  end
end
