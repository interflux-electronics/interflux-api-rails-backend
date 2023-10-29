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
        Person
      end

      def serializer_class
        V1::Admin::PersonSerializer
      end

      def permitted_filters
        %i[
          full_name
        ]
      end

      def permitted_includes
        %i[
          company_members
          companies
          image
          images
          person_images
          person_images.image
        ]
      end

      def creatable_attributes
        %i[
          first_name
          last_name
          chinese_name
          phone
          email
          avatar_path
          avatar_variations
          avatar_caption
          avatar_alt
        ]
      end

      def creatable_relationships
        %i[
          image
        ]
      end
    end
  end
end
