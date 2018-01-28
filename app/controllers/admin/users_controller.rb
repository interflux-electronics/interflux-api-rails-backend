module Admin
  class UsersController < ApplicationController
    def index
      return show if token
      forbidden
    end

    # Return product category with slug
    # Return product category with ID
    # GET /admin/users/?token=:token
    def show
      return forbidden unless token
      decoded = JsonWebToken.decode(token)
      return invalid_token unless decoded
      byebug
      user = Users.find_by_id(params[:id])
      render status: 200, json: json_resource(Admin::UserResource, user)
    end

    private

    def token
      params.permit(:token)
    end

    def invalid_token
      json_error(401, 'invalid-token', 'Your JWT token is either invalid or expired.')
    end

    def authenticate
      user = User.find_by(email: params[:email])
      return invalid_email unless user
      return invalid_password unless user.authenticate(params[:password])
      JsonWebToken.encode(user_id: user.id)
      render json: { auth_token: JsonWebToken.encode(user_id: user.id) }
    end
  end
end
