class ApplicationController < ActionController::API
  # To make all controllers behave according to the JSON API spec
  # https://jsonapi.org/
  include JsonApiController

  # To allow controllers to set and read cookies
  include ActionController::Cookies
end
