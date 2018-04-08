class ApplicationController < ActionController::Base
  # Return an array of resource
  # GET /namespace/route
  # GET /namespace/?filter={key:value,key:value}
  def index
    return show if params[:slug] # Redirect if :slug based
    resources = resource_klass.all
    permitted_filters&.each do |key, value|
      resources = resources.where("#{key.underscore}": value)
    end
    json = serializer_klass.new(resources).serialized_json
    render status: 200, json: json
  end

  # Return a single resource
  # GET /namespace/route/:id
  # GET /namespace/route/?slug=:slug
  # Note: For human and SEO we avoid embedding UUIDs in URLs. Instead we use
  # hyphenated strings referred to as slugs. These slugs are the only bit of
  # information the front-end can send to the API to fetch a resource. Given
  # these are unique in every table, we can use them for for finding resources
  # just like we would with an :id.
  def show
    resource = resource_klass.find_by_id(params[:id]) if params[:id]
    resource = resource_klass.find_by_slug(params[:slug]) if params[:slug]
    return resource_not_found if resource.nil?
    options = {}

    # TODO: Make top level includes work
    # options[:include] = includes if includes

    json = serializer_klass.new(resource, options).serialized_json
    render status: 200, json: json
  end

  # Update a resource
  # POST /namespace/route
  def create
    resource = resource_klass.new(merged_attributes)
    if resource.save!
      json = serializer_klass.new(resource).serialized_json
      render status: 201, json: json
    else
      render status: 422, json: json_errors(resource)
    end
  end

  # Update a resource
  # PUT /namespace/route/:id
  def update
    resource = resource_klass.find_by_id(params[:id])
    return resource_not_found if resource.nil?
    if resource.update!(merged_attributes)
      json = serializer_klass.new(resource).serialized_json
      render status: 204, json: json
    else
      render status: 422, json: json_errors(resource)
    end
  end

  # Delete a resource
  # DELETE /namespace/route/:id
  def destroy
    resource = resource_klass.find_by_id(params[:id])
    return resource_not_found if resource.nil?
    resource.destroy

    # TODO: also destroy everything related and dependent on this resource

    head 204
  end

  # Make sure this action can't be abused
  def edit
    forbidden
  end

  # Make sure this action can't be abused
  def new
    forbidden
  end

  private

  def merged_attributes
    params
      .require(:data)
      .require(:attributes)
      .permit(attributes)
      .merge(relationships)
  end

  def permit_relationship(key)
    params
      .require(:data)
      .require(:relationships)
      .require(key)
      .require(:data)
      .permit(
        :id,
        :type
      )
  end

  def permitted_filters
    return unless params[:filter]
    params
      .require(:filter)
      .permit(filters)
      .to_hash
  end

  # def permitted_includes
  #   params[:include].split(',').select { |i| i[/images|translations$/] }.map(&:to_sym)
  # end

  # Render a JSON API response Netlflix' Fast JSON API Serializers
  # https://github.com/Netflix/fast_jsonapi
  # Example: render_json(200, product, Admin::ProductSerializer)
  def render_response(status, record, serializer)
    json = serializer.new(record).serialized_json
    render status: status, json: json
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

  # Common error messages:
  # We aim to always return a JSON error instead of dropping requests.

  def forbidden
    render_error(403, 'forbidden', 'This request is forbidden.')
  end

  def route_not_found
    render_error(404, 'route-not-found', 'This route does not exist in Rails. Check routes.rb whether 1) it exists and 2) if you have added the hyphenated path.')
  end

  def resource_not_found
    render_error(422, 'resource-not-found', 'The controller attempt to find your resource (by ID or slug) but could not find anything that matched. Are you sure it exists?')
  end
end
