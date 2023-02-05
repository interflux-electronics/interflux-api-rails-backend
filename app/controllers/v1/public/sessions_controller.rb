module V1
  module Public
    class SessionsController < ApplicationController
      after_create :fetch_country_from_ip

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

      def fetch_country_from_ip
        AddIpMetaToSessionJob.perform_later(self, ip)
      end

      def ip
        request.remote_ip
      end
    end
  end
end
