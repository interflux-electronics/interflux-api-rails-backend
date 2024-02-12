module V1
  module Admin
    class VisitsController < ApplicationController
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
        Visit
      end

      def serializer_class
        V1::Admin::VisitSerializer
      end

      def permitted_filters
        %i[
          host
        ]
      end

      def permitted_includes
        %i[
          server_side_renders
          client_side_renders
          user
        ]
      end
    end
  end
end
