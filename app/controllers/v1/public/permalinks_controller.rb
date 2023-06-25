module V1
  module Public
    class PermalinksController < ApplicationController
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
        Permalink
      end

      def serializer_class
        V1::Public::PermalinkSerializer
      end

      def permitted_filters
        %i[
          slug
        ]
      end
    end
  end
end
