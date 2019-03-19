# Inspired from:
# https://medium.com/binar-academy/rails-api-jwt-authentication-a04503ea3248
#
module V1
  module Admin
    class AuthenticationController < V1::AdminController

      # Login step 1 - verify email
      def verify_email
        user = User.find_by(email: params[:email])
        return error_email if user.nil?
        json = V1::Admin::UserSerializer.new(user).serialized_json
        render status: 200, json: json
      end

      # Login step 2 - verify password
      def verify_password
        user = User.find_by(id: params[:id])
        return error_id if user.nil?

        # TODO: return error_suspended if user.suspended?

        authenticated_user = user.authenticate(params[:password])
        return error_password unless authenticated_user.present?

        # Prepare authentication token
        data = { user_id: authenticated_user.id }
        time = Time.now + 24.hours.to_i
        token = JsonWebToken.new(data, time).encode
        json = {
          token: token,
          exp: time.strftime('%m-%d-%Y %H:%M')
        }

        # Return the token
        render status: 200, json: json
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
      #     exp: time.strftime('%m-%d-%Y %H:%M')
      #   }
      #
      #   render status: 200, json: json
      # end

      private

      def login_params
        params.permit(:email, :password)
      end

      def error_email
        render_error(
          422,
          'no-user-for-email',
          "No user exists with email '#{params[:email]}'."
        )
      end

      def error_id
        render_error(
          422,
          'no-user-for-id',
          "No user exists with ID '#{params[:id]}'."
        )
      end

      # def error_suspended
      #   render_error(
      #     422,
      #     'suspended-user',
      #     "This user was suspended. Please contact Jan."
      #   )
      # end

      def error_password
        render_error(
          422,
          'wrong-password',
          "This password is wrong. This has been logged. More failed attempts and the account will be locked automatically."
        )
      end
    end
  end
end
