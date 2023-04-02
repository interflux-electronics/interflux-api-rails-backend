module V1
  module Admin
    class UsersController < V1::AdminController
      def index
        forbidden
      end

      def show
        # In case the user does not have the "read_users" ability, the user
        # can still retrieve their own user record.
        @user_is_able = true if params[:id] == @auth_user.id

        allow_show
      end

      def create
        forbidden
      end

      def update
        # In case the user does not have the "update_users" ability, the user
        # can still update their own user record.
        @user_is_able = true if params[:data][:id] == @auth_user.id

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
    end
  end
end
