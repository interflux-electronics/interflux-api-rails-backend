module V1
  module Admin
    class CompanyMembersController < V1::AdminController
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
        allow_destroy
      end

      private

      def model_class
        CompanyMember
      end

      def serializer_class
        V1::Admin::CompanyMemberSerializer
      end

      def creatable_attributes
        %i[
          title
          email
          phone
          public
          public_title
          public_email
          public_phone
          rank_among_companies
          rank_among_members
        ]
      end

      def creatable_relationships
        %i[
          company
          person
        ]
      end
    end
  end
end
