module Errors
  extend ActiveSupport::Concern

  # Common errors

  def forbidden
    render_error(403, 'forbidden', 'This request is forbidden. The resource exists, but no action was assigned in the controller.')
  end

  def route_not_found
    render_error(404, 'route-not-found', 'This route does not match any of the routes in `config/routes.rb`. Please check whether it exists and whether it needs an explicit hyphenated path.')
  end

  def resource_not_found
    render_error(422, 'resource-not-found', 'No record with this UUID was found in the database.')
  end

  # Wraps a single error in JSON API format
  # http://jsonapi.org/format/#errors
  # Example: render_error(422, 'not-found', 'No product with this ID was found.')
  def render_error(status, code, detail)
    render status: status, json: {
      errors: [{
        status: status.to_s,
        code: code,
        detail: detail
      }]
    }
  end
end
