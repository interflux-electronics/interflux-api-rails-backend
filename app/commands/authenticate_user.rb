# frozen_string_literal: true

# https://www.pluralsight.com/guides/ruby-ruby-on-rails/token-based-authentication-with-ruby-on-rails-5-api
# https://github.com/nebulab/simple_command

class AuthenticateUser
  prepend SimpleCommand

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    JsonWebToken.encode(user_id: user.id) if user
  end

  private

  attr_accessor :email, :password

  def user
    user = User.find_by_email(email)
    return user if user && user.authenticate(password)
    errors.add :user_authentication, 'invalid credentials'
    nil
  end
end
