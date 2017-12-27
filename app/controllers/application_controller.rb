class ApplicationController < JSONAPI::ResourceController
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

  # Serialise and return 1 record into JSON using JSON API resources
  # Example: render status: 200, json: json_resource(Admin::ProductResource, @product, nil)
  def json_resource(klass, record, context = nil)
    JSONAPI::ResourceSerializer.new(klass).serialize_to_hash(klass.new(record, context))
  end

  # Serialise and return an array of records into JSON using JSON API resources
  # Example: render status: 200, json: json_resources(Admin::ProductResource, @products, nil)
  def json_resources(klass, records, context = nil)
    resources = records.map { |record| klass.new(record, context) }
    JSONAPI::ResourceSerializer.new(klass).serialize_to_hash(resources)
  end

  # Wraps a single error in JSON API format
  # Documentation: http://jsonapi.org/format/#errors
  # Usage: return not_found unless @product.present?
  # def not_found
  #   json_error(
  #     status: 422,
  #     code: 'not-found',
  #     detail: 'No product with this ID was found.'
  #   )
  # end
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
