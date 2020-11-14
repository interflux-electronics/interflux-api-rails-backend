module V1
  module Admin
    class PeopleController < V1::AdminController
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
        allow_update
      end

      def destroy
        forbidden
      end

      private

      def model_class
        Person
      end

      def serializer_class
        V1::Admin::PersonSerializer
      end

      def permitted_filters
        %i[
          first_name
        ]
      end

      def permitted_includes
        %i[
          company_members
          companies
        ]
      end

      def creatable_attributes
        %i[
          first_name
          last_name
          chinese_name
          phone
          email
        ]
      end
    end
  end
end
