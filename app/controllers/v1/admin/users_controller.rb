module V1
  module Admin
    class UsersController < V1::AdminController
      def index
        forbidden
      end

      def show
        token = JsonWebToken.new(auth_header).decode
        user = User.find(token[:user_id])

        # Exit, if no user is found for the UUID hidden within the encrypted token.
        return forbidden if user.nil?

        # Exit, if the requested UUID doesn't match the UUID inside of the token.
        return forbidden if params[:id] != token[:user_id]

        # If both tests pass, use the standard JSON approach of serving data.
        allow_show
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
    end
  end
end
