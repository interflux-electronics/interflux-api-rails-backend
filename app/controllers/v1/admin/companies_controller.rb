module V1
  module Admin
    class CompaniesController < V1::AdminController
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

      def resource_klass
        Company
      end

      def serializer_klass
        V1::Admin::CompanySerializer
      end

      def permitted_includes
        %i[
          country
        ]
      end

      def creatable_attributes
        %i[
          address
          business_name
          legal_name
          emails
          fax
          latitude
          longitude
          phone
          public
          slug
          website
          order
        ]
      end

      def creatable_relationships
        %i[
         country
        ]
      end
    end
  end
end
