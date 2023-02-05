module V1
  module Public
    class SessionsController < ApplicationController
      def index
        forbidden
      end

      def show
        allow_show
      end

      def create
        allow_create
      end

      def update
        forbidden
      end

      def destroy
        forbidden
      end

      private

      def model_class
        Session
      end

      def serializer_class
        V1::Public::SessionSerializer
      end

      def creatable_attributes
        %i[
          href
          referrer
          browser_app
          browser_width
          browser_height
          browser_languages
        ]
      end
    end
  end
end
