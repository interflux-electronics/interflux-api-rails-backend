module V1
  module Public
    class DocumentsController < ApplicationController
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
        Document
      end

      def serializer_class
        V1::Public::DocumentSerializer
      end

      def permitted_includes
        %i[
          cdn_files
        ]
      end

      def permitted_filters
        %i[
          name
        ]
      end

      def permanent_filters
        {
          public: true
        }
      end
    end
  end
end
