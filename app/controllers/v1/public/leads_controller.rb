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

      def creatable_attributes
        %i[
          name
          company
          email
          mobile
          message
          purpose
          source
          ip
          ip_region
          ip_city
        ]
      end

      def creatable_relationships
        %i[
          country
          ip_country
        ]
      end

      def permitted_filters
        %i[]
      end

      def permitted_includes
        %i[]
      end

      def after_create(lead)
        PostLeadToSlackJob.perform_later lead
      end
    end
  end
end
