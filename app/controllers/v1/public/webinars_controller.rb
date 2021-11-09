module V1
  module Public
    class WebinarsController < ApplicationController
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
        Webinar
      end

      def serializer_class
        V1::Public::WebinarSerializer
      end

      def permanent_filters
        {
          public: true
        }
      end

      def permitted_includes
        %i[
          image
          video
          person
          document
        ]
      end
    end
  end
end
