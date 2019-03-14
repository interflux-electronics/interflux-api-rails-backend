# Inspired from:
# https://medium.com/binar-academy/rails-api-jwt-authentication-a04503ea3248
#
module V1
  module Admin
    class AuthenticationController < V1::AdminController
      def login
        @user = User.find_by_email(login_params[:email])

        wrong_email if @user.nil?
        wrong_password unless @user&.authenticate(login_params[:password])

        data = { user_id: @user.id }
        token = JsonWebToken.new(data).encode
        time = Time.now + 24.hours.to_i
        json = {
          token: token,
          exp: time.strftime('%m-%d-%Y %H:%M')
        }

        render status: 200, json: json
      end

      private

      def login_params
        params.permit(:email, :password)
      end

      def wrong_email
        render_error(
          422,
          'wrong-email',
          "No user exists for email: #{params[:email]}."
        )
      end

      def wrong_password
        render_error(
          422,
          'wrong-password',
          'The password entered is not correct.'
        )
      end
    end
  end
end
