module V1
  module Admin
    class UsersController < V1::AdminController
      def index
        forbidden
      end

      def show
        # Exit, if the user ID in the auth token does not match the one being retrieved
        return no_user_match if params[:id] != auth_user.id

        allow_show
      end

      def create
        forbidden
      end

      def update
        # Exit, if the user ID in the auth token does not match the one being edited
        return no_user_match if params[:data][:id] != auth_user.id

        allow_update
      end

      def destroy
        forbidden
      end

      private

      def model_class
        User
      end

      def serializer_class
        V1::Admin::UserSerializer
      end

      def permitted_includes
        %i[
          person
        ]
      end

      def creatable_attributes
        %i[
          email
          password
        ]
      end

      def creatable_relationships
        %i[
          person
        ]
      end

      def no_user_match
        render_error(
          401,
          'unauthorized',
          'Your auth token does not match the user you are editing / retrieving. How naughty!',
          meta
        )
      end
    end
  end
end
