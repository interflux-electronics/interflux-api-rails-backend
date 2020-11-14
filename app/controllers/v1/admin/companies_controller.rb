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

      def model_class
        Company
      end

      def serializer_class
        V1::Admin::CompanySerializer
      end

      def permitted_filters
        %i[
          business_name
        ]
      end

      def permitted_includes
        %i[
          country
          people
          markets
          company_members
          company_markets
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
