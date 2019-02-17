module V1
  module Public
    class CountriesController < ApplicationController
      include JsonApi
      include Errors

      def index
        allow_index
      end

      def show
        user_can_fetch_one_by_id
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
        Country
      end

      def serializer_klass
        Public::V1::CountrySerializer
      end

      def creatable_attributes
        %i[]
      end

      def creatable_relationships
        %i[]
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
