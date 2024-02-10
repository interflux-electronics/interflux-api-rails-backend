module V1
  module Public
    class ServerSideRendersController < ApplicationController
      def index
        forbidden
      end

      def show
        forbidden
      end

      def create
        allow_create({ ip: request.remote_ip })
      end

      def update
        forbidden
      end

      def destroy
        forbidden
      end

      private

      def model_class
        ServerSideRender
      end

      def serializer_class
        V1::Public::ServerSideRenderSerializer
      end

      def creatable_attributes
        %i[
          visit_id
          host
          referrer
          user_agent
        ]
      end

      def creatable_relationships
        %[
          visit
        ]
      end
    end
  end
end
