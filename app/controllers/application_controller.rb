class ApplicationController
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
    json_error(403, 'forbidden', 'This request is forbidden.')
  end

  def route_not_found
    json_error(404, 'route-not-found', 'This route does not exist in Rails. Check routes.rb whether 1) it exists and 2) if you have added the hyphenated path.')
  end

  def resource_not_found
    json_error(422, 'resource-not-found', 'The controller attempt to find your resource (by ID or slug) but could not find anything that matched. Are you sure it exists?')
  end

  # Wraps a single error in JSON API format
  # Example: json_error(422, 'not-found', 'No product with this ID was found.')
  # Documentation: http://jsonapi.org/format/#errors
  def json_error(status, code, detail)
    render status: status, json: {
      errors: [{
        status: status.to_s,
        code: code,
        detail: detail
      }]
    }
  end

  # TODO: review
  # Converts the errors on a resource to a valid JSON API error response
  # How to use:
  # suburb.errors.add(:postcode, 'Message for users',
  #                   error: {
  #                     code: 'error_code_1',
  #                     detail: 'Message for developers.',
  #                     meta: { extras: 'details' }
  #                   })
  def json_errors(resource)
    @errors = []
    resource.errors.details.map do |_association, errors|
      errors.map do |detail|
        next if detail[:error].blank?
        @errors.push(detail[:error])
      end
    end.flatten
    { errors: @errors }
  end
end
