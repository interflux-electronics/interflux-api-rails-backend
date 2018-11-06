module V1
  module Public
    class LeadsController < ApplicationController
      include JsonApi
      include Errors

      def index
        forbidden
      end

      def show
        forbidden
      end

      def create
        user_can_create
      end

      def update
        forbidden
      end

      def destroy
        forbidden
      end

      private

      def resource_klass
        Lead
      end

      def serializer_klass
        LeadSerializer
      end

      def attributes
        %i[
          name
          company
          email
          mobile
          message
          purpose
          source
        ]
      end

      def relationships
        %i[]
      end

      def filters
        %i[]
      end

      def includes
        %i[]
      end
    end
  end
end
