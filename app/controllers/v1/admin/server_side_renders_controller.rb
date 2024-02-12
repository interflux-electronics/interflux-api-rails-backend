module V1
  module Admin
    class ServerSideRendersController < ApplicationController
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
        ServerSideRender
      end

      def serializer_class
        V1::Admin::ServerSideRenderSerializer
      end
    end
  end
end
