module JsonApi
  extend ActiveSupport::Concern

  included do
    before_action :check_content_type
  end

  # CRUD
  #
  # In order to follow the JSON API specs, unsported request endpoints should
  # return a 403 forbidden (instead of dropping the request without feedback).
  #
  # https://jsonapi.org/format/#crud-creating-responses
  #
  # By default all CRUDs are 403 forbidden. The idea is that you overwrite these
  # per controller with a well defined reusable method. For example:
  #
  # def index
  #   allow_index
  # end
  #
  # def show
  #   allow_show
  # end
  #
  # def create
  #   allow_create
  # end
  #
  # def update
  #   allow_update
  # end
  #
  # def destroy
  #   allow_destroy
  # end
  #
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

  def destroy
    forbidden
  end

  def edit
    forbidden
  end

  def new
    forbidden
  end

  def render_404
    route_not_found
  end

  private

  # FETCHING MANY RESOURCES
  #
  # GET /products
  # GET /products?filter[foo]=thing
  # GET /products?filter[foo]=thing&filter[bar]=true
  #
  # This method allows all records to be fetched, with or without filters.
  # Use this method only in the `index`.
  #
  # def index
  #   allow_index
  # end
  #
  def allow_index(allowed = true)
    # Treat each URL that contains `?slug=something` as a `show` request.
    return show if params[:slug]

    # Return 403 unless explicitely allowed in the controller
    return forbidden unless allowed

    # Return 403 if unknown filters are used
    return forbidden_filter if unknown_filter?

    # First we gather all records of the model class.
    resources = resource_klass.all

    # Then we reduce this collection with the permanent and requested filters.
    filters&.each do |key, value|
      resources = resources.where("#{key.to_s.underscore}": value)
    end

    # Here we prepare the options we can pass to the serializers.
    options = {}

    # Most importantly, we define which related models to include in the request.
    options[:include] = strong_includes if strong_includes

    # We create a JSON response from the records we collected using the fast and
    # JSON API compliant Netflux serializers.
    json = serializer_klass.new(resources, options).serialized_json

    # Finally we return the JSON with a 200.
    render status: 200, json: json
  end

  # FETCHING SINGLE RESOURCES
  #
  # GET /products/:uuid
  # GET /products/?slug=foo
  #
  # def show
  #   allow_show
  # end
  #
  # def show
  #   user_can_fetch_one_by_id
  # end
  #
  # What are slugs?
  # Slugs are strings that act as unique identifiers, just like UUIDs do.
  # These are often parts of the URL that we send to the API and which map to
  # one unique resource.
  #
  # Person.create({
  #   name: 'Jan Werkhoven'
  #   slug: 'jan-werkhoven'
  # })
  #
  # For example:
  # www.foo.com/people/jan-werkhoven
  # Would fetch:
  # GET api.foo.com/people/?slug=jan-werkhoven
  # Which should return the same as the UUID:
  # GET api.foo.com/people/797e2b42-f8c8-5712-b6b0-486aeb1bcf94
  #
  def allow_show
    return find_by_slug if params[:slug]

    find_by_id
  end

  def find_by_slug
    resource = resource_klass.find_by slug: params[:slug]

    fetch_one resource
  end

  def find_by_id
    resource = resource_klass.find_by id: params[:id]

    fetch_one resource
  end

  def fetch_one(resource)
    return resource_not_found if resource.nil?

    options = {}

    options[:include] = strong_includes if strong_includes
    json = serializer_klass.new(resource, options).serialized_json

    render status: 200, json: json
  end

  # INCLUDES
  #
  # When fetching a record, to also include its relationships, the JSON API spec
  # states to include them all keys, comma-separated, in the `include` URI param
  # like so: GET /articles/123?include=author,author.books
  #
  # https://jsonapi.org/format/#fetching-includes
  #
  # The method below returns an array of all requested include keys that are
  # also white listed in the controller under `permitted_includes`.
  #
  def strong_includes
    # The `include` param is optional. Ignore if not present.
    return unless params[:include]

    # Intersecting both arrays, keeping only the keys that appear in both
    permitted_includes & requested_includes
  end

  # Returns array of requested include keys.
  def requested_includes
    params[:include]
      .split(',')
      .collect { |item| item.underscore.to_sym }
  end

  # FILTERS
  #
  # To fetch all records of a type that match certain criteria, the JSON API
  # spec stipulates to use the `filter` param, but doesn't add anymore details.
  #
  # https://jsonapi.org/format/#fetching-filtering
  #
  # This is how Ember would encode the filter query:
  # GET /products?filter[foo]=thing
  # GET /products?filter[foo]=thing&filter[bar]=true
  #
  # The method below permits only those filter key-value pairs of which the keys
  # are listed in `permitted_filters` on the controller.
  #
  def filters
    hash = {}
    hash = hash.merge(permanent_filters) unless permanent_filters.nil?
    hash = hash.merge(requested_filters) if params[:filter]
    hash
  end

  def permanent_filters
    nil
  end

  def requested_filters
    permitted = permitted_filters.collect(&:to_s)

    params
      .require(:filter)
      .permit(permitted)
      .to_hash
  end

  def unknown_filter?
    filter = request.params[:filter]

    return false unless filter

    !filter.all? do |key_value|
      key = key_value[0]
      permitted_filters.include? key.to_sym
    end
  end

  # CREATING
  #
  # POST /products, params { foo: bar }
  #
  # def create
  #   allow_create
  # end
  #
  def allow_create
    resource = resource_klass.new(attributes_and_relationships)
    if resource.save!
      after_create(resource)
      json = serializer_klass.new(resource).serialized_json
      render status: 201, json: json
    else
      render status: 422, json: json_errors(resource)
    end
  end

  def attributes_and_relationships
    strong_attributes
      .merge(strong_relationships)
  end

  # Allow only predifined list of attributes that can saved to the resource
  def strong_attributes
    return {} if creatable_attributes.empty?

    params
      .require(:data)
      .require(:attributes)
      .permit(creatable_attributes)
  end

  # Return a hash of permitted relationship and strong IDs pulled from the params.
  # Usage: Make sure each controller has a similar array:
  #
  # def creatable_relationships
  #   %i[
  #     main_category
  #     sub_category
  #   ]
  # end
  #
  def strong_relationships
    return {} if creatable_relationships.empty?

    params['data']['relationships']
    # First we convert the array into  we convert `relationships` into a nested array like:
    # [[:main_category, "d6461197-e618-5502-95a5-1e171f8f71e9"], [:sub_category, "8147cd48-12b6-500e-a001-d80288d644f1"]]
    # The keys are underscored for later use when creating / updating the resource.
    # The values are strong IDs grabbed from the JSON API structured package.

    nested_array = creatable_relationships.collect do |key|
      db_key = "#{key}_id"
      id = nil
      relationship_exists = params['data']['relationships'] && params['data']['relationships'][key]
      if relationship_exists
        id = params
             .require(:data)
             .require(:relationships)
             .require(key)
             .require(:data)
             .permit(
               :id,
               :type
             )
             .fetch(:id)
      end
      [db_key, id]
    end
    # Then we convert the array into a hash and return it.
    # Example: {:main_category=>"d6461197-e618-5502-95a5-1e171f8f71e9", :sub_category=>"8147cd48-12b6-500e-a001-d80288d644f1"}
    Hash[nested_array]
  end

  # UPDATING
  #
  # PUT /products/:uuid, params { foo: bar }
  #
  # def create
  #   allow_update
  # end
  #
  def allow_update
    resource = resource_klass.find_by id: params[:id]

    return resource_not_found if resource.nil?

    if resource.update!(attributes_and_relationships)
      json = serializer_klass.new(resource).serialized_json
      render status: 204, json: json
    else
      render status: 422, json: json_errors(resource)
    end
  end

  # DELETING
  #
  # DELETE /products/:uuid
  #
  # def create
  #   allow_delete
  # end
  #
  def allow_delete
    resource = resource_klass.find_by id: params[:id]

    return resource_not_found if resource.nil?

    # TODO: first destroy everything that's uniquely related to this resource?

    resource.destroy

    head 204
  end

  # SIDE-EFFECTS
  #
  # TODO: Move to conventional approach: https://api.rubyonrails.org/classes/ActiveRecord/Callbacks.html
  #
  # To trigger side-effects to occur after succesfully creating a record, add
  # the `after_create` method to your controller. Example:
  #
  # def after_create(lead)
  #   PostLeadToSlackJob.perform_later lead
  # end
  #
  def after_create(record)
    nil
  end

  # ERRORS

  def check_content_type
    wrong_content_type unless request.content_type == 'application/vnd.api+json'
  end

  def unauthorized(meta = nil)
    render_error(
      401,
      'unauthorized',
      'You are not authorized to make this request. Please include a valid token in the Authorization HTTP header.',
      meta
    )
  end

  def forbidden(meta = nil)
    render_error(
      403,
      'forbidden',
      'This request is forbidden. The resource exists, but no action was assigned in the controller.',
      meta
    )
  end

  def forbidden_filter
    render_error(
      403,
      'forbidden',
      'One of the filters params in the URL is not allowed. Please review.'
    )
  end

  def route_not_found(meta = nil)
    render_error(
      404,
      'route-not-found',
      'This route does not match any of the routes in `config/routes.rb`. Please check whether it exists and whether it needs an explicit hyphenated path.',
      meta
    )
  end

  def wrong_content_type
    render_error(
      415,
      'unsupported-media-type',
      'This API follows the JSON API standards and can therefor only accepts request with Content-Type "application/vnd.api+json".'
    )
  end

  def resource_not_found(meta = nil)
    render_error(
      422,
      'resource-not-found',
      'No record with this UUID was found in the database.',
      meta
    )
  end

  # Wraps a single error in JSON API format
  # http://jsonapi.org/format/#errors
  # Example: render_error(422, 'not-found', 'No product with this ID was found.')
  def render_error(status, code, detail, meta = nil)
    json = {
      errors: [{
        status: status.to_s,
        code: code,
        detail: detail
      }]
    }

    json['errors']['meta'] = meta unless meta.nil?

    render status: status, json: json
  end
end
