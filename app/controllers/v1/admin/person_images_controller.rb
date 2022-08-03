module V1
  module Admin
    class PersonImagesController < ApplicationController
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
        PersonImage
      end

      def serializer_class
        V1::Admin::PersonImageSerializer
      end

      def creatable_relationships
        %i[
          person
          image
        ]
      end
    end
  end
end
