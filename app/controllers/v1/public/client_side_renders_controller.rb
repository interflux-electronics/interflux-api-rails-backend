module V1
  module Public
    class ClientSideRendersController < ApplicationController
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
        ClientSideRender
      end

      def serializer_class
        V1::Public::ClientSideRenderSerializer
      end

      def creatable_attributes
        %i[
          visit_id
          host
          referrer
          user_agent
          viewport_width
          viewport_height
          user_id
        ]
      end

      def creatable_relationships
        %[
          visit
          user
        ]
      end
    end
  end
end
