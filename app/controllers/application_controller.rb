class ApplicationController < ActionController::API
  # To give all controllers the tools to be JSON API spec compliant.
  include JsonApiController

  # To allow controllers to set and read cookies.
  include ActionController::Cookies

  # https://pragmaticstudio.com/tutorials/rails-session-cookies-for-api-authentication
  include ActionController::RequestForgeryProtection
  protect_from_forgery with: :exception
end
