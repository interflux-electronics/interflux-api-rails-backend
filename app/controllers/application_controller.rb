class ApplicationController < ActionController::API
  # Give all controllers the methods for handling requests per JSON API spec.
  include JsonApiController

  # Allow controllers to set and read cookies.
  include ActionController::Cookies

  # Allow all controllers to log with a shorthand.
  def log
    Rails.logger
  end
end
