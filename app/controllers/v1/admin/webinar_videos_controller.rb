module V1
  module Admin
    class WebinarVideosController < ApplicationController
      def index
        allow_index
      end

      def show
        allow_show
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

      def model_class
        WebinarVideo
      end

      def serializer_class
        V1::Admin::WebinarVideoSerializer
      end

      def creatable_relationships
        %i[
          webinar
          video
        ]
      end
    end
  end
end
