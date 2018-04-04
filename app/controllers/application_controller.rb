class ApplicationController < ActionController::Base
  def index
    forbidden
  end

  def show
    forbidden
  end

  def create
    forbidden
  end

  def update
    forbidden
  end

  def edit
    forbidden
  end

  def new
    forbidden
  end

  def destroy
    forbidden
  end

  def forbidden
    render_error(403, 'forbidden', 'This request is forbidden.')
  end

  def route_not_found
    render_error(404, 'route-not-found', 'This route does not exist in Rails. Check routes.rb whether 1) it exists and 2) if you have added the hyphenated path.')
  end

  def resource_not_found
    render_error(422, 'resource-not-found', 'The controller attempt to find your resource (by ID or slug) but could not find anything that matched. Are you sure it exists?')
  end

  def render_response(status, record, serializer)
    json = serializer.new(record).serialized_json
    render status: status, json: json
  end

  # Wraps a single error in JSON API format
  # Documentation: http://jsonapi.org/format/#errors
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
