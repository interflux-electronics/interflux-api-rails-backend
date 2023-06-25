module V1
  module Admin
    class PermalinksController < ApplicationController
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
        Permalink
      end

      def serializer_class
        V1::Admin::PermalinkSerializer
      end

      def creatable_attributes
        %i[
          slug
          redirect_to
          notes
        ]
      end

      def permitted_filters
        %i[
          slug
        ]
      end
    end
  end
end
