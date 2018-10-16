module Admin
  class UsersController < ApplicationController
    include Authentication

    # Return the current userr
    # def show
    #   return forbidden unless token
    #   decoded = JsonWebToken.decode(token)
    #   return invalid_token unless decoded
    #   user = Users.find_by_id(params[:id])
    #   render status: 200, json: json_resource(Admin::UserSerializer, user)
    # end
    #
    # private

    # def token
    #   params.permit(:token)
    # end
    # def authenticate
    #   user = User.find_by(email: params[:email])
    #   return invalid_email unless user
    #   return invalid_password unless user.authenticate(params[:password])
    #   JsonWebToken.encode(user_id: user.id)
    #   render json: { auth_token: JsonWebToken.encode(user_id: user.id) }
    # end
    #
    # def invalid_token
    #   render_error(401, 'invalid-token', 'Your JWT token is either invalid or expired.')
    # end
  end
end
