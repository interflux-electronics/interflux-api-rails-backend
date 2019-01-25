module V1
  module Admin
    class LanguagesController < ApplicationController
      include JsonApi
      include Errors

      def index
        user_can_fetch_all
      end

      def show
        user_can_fetch_one_by_id_or_slug
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

      def resource_klass
        Language
      end

      def serializer_klass
        V1::Public::LanguageSerializer
      end

      def creatable_attributes
        %i[]
      end

      def creatable_relationships
        %i[]
      end

      def permanent_filters
        {
          supported: true
        }
      end

      def permitted_filters
        %i[]
      end

      def permitted_includes
        %i[]
      end
    end
  end
end
