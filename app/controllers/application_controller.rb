class ApplicationController < ActionController::API
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

  # Common high level error messages

  def route_not_found
    render_error(404, 'route-not-found', 'This route does not exist in Rails. Check routes.rb whether 1) it exists and 2) if you have added the hyphenated path.')
  end
end
