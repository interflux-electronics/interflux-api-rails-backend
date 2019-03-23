# Inspired from:
# https://medium.com/binar-academy/rails-api-jwt-authentication-a04503ea3248
#
module V1
  module Admin
    class AuthenticationController < ApplicationController

      # Login step 1 - verify email
      def verify_email
        user = User.find_by(email: params[:email])
        return 401 if user.nil?
        render status: 200
      end

      # Login step 2 - verify password
      def verify_password
        user = User.find_by(email: params[:email])
        return 401 if user.nil?

        # TODO: return 403 if user.suspended?

        authenticated_user = user.authenticate(params[:password])
        return 401 unless authenticated_user.present?

        # Prepare authentication token
        data = { user_id: authenticated_user.id }
        time = Time.now + 24.hours.to_i
        token = JsonWebToken.new(data, time).encode

        # json = UserSerializer.new(user).serialized_json
        options = {}
        options[:include] = [:person]
        json1 = UserSerializer.new(user, options).serializable_hash
        json2 = {
          auth: {
            token: token,
            expiry: time.strftime('%m-%d-%Y %H:%M')
          }
        }
        json = json1.merge(json2).to_json

        # Return the token
        render status: 200, json: json
      end

      # The auth token is the only bit Ember stores in localStorage.
      # The next time the user opens the app, the user data will be forgotten.
      # Ember then sends up the token and expects back the user record belonging
      # to the token.
      def get_auth_user
        #
      end

      # Keep a token alive by extending the expirty (as long as users use the UI)
      def extend_expiry
        #
      end

      # Invalidate a token (when users log out)
      def logout
        #
      end

      # def login
      #   @user = User.find_by_email(login_params[:email])
      #
      #   wrong_email if @user.nil?
      #   wrong_password unless @user&.authenticate(login_params[:password])
      #
      #   data = { user_id: @user.id }
      #   token = JsonWebToken.new(data).encode
      #   time = Time.now + 24.hours.to_i
      #   json = {
      #     token: token,
      #     expiry: time.strftime('%m-%d-%Y %H:%M')
      #   }
      #
      #   render status: 200, json: json
      # end

      private

      def login_params
        params.permit(:email, :password)
      end

      # def error_email
      #   render_error(
      #     422,
      #     'no-user-for-email',
      #     "No user exists with email '#{params[:email]}'."
      #   )
      # end
      #
      # def error_id
      #   render_error(
      #     422,
      #     'no-user-for-id',
      #     "No user exists with ID '#{params[:id]}'."
      #   )
      # end

      # def error_suspended
      #   render_error(
      #     422,
      #     'suspended-user',
      #     "This user was suspended. Please contact Jan."
      #   )
      # end

      # def error_password
      #   render_error(
      #     422,
      #     'wrong-password',
      #     "This password is wrong. This has been logged. More failed attempts and the account will be locked automatically."
      #   )
      # end
    end
  end
end
