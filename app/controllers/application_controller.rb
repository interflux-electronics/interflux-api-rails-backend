class ApplicationController < ActionController::API
  # To give all controllers the tools to be JSON API spec compliant.
  include JsonApiController

  # To allow controllers to set and read cookies.
  include ActionController::Cookies
end
