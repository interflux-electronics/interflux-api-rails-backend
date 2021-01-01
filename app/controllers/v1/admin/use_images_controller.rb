module V1
  module Admin
    class UseImagesController < ApplicationController
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
        UseImage
      end

      def serializer_class
        V1::Admin::UseImageSerializer
      end

      def creatable_relationships
        %i[
          use
          image
        ]
      end
    end
  end
end
