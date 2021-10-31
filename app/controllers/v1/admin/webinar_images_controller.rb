module V1
  module Admin
    class WebinarImagesController < ApplicationController
      def index
        allow_index
      end

      def show
        allow_show
      end

      def create
        allowe_create
      end

      def update
        allow_update
      end

      def destroy
        allow_destroy
      end

      private

      def model_class
        WebinarImage
      end

      def serializer_class
        V1::Admin::WebinarImageSerializer
      end

      def creatable_relationships
        %i[
          webinar
          image
        ]
      end
    end
  end
end
