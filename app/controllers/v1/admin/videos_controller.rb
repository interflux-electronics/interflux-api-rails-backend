module V1
  module Admin
    class VideosController < ApplicationController
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
        Video
      end

      def serializer_class
        V1::Admin::VideoSerializer
      end

      def permitted_includes
        %i[
          cdn_files
          webinar
        ]
      end

      def permitted_filters
        %i[
          title_admin
        ]
      end

      def creatable_attributes
        %i[
          title_admin
          title_public
        ]
      end

      def creatable_relationships
        %i[
          webinar
        ]
      end
    end
  end
end
