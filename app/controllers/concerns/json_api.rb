# TODO: Tackle N+1 queries by enabling .include()
# https://medium.com/@codenode/10-tips-for-eager-loading-to-avoid-n-1-queries-in-rails-2bad54456a3f

# This module centralises all logic needed to adhere to the JSON API spec.
# https://jsonapi.org/
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

  def creatable_attributes
    %i[]
    # %i[
    #   name
    #   company
    #   email
    #   mobile
    #   message
    #   purpose
    #   source
    #   ip
    #   ip_region
    #   ip_city
    # ]
  end

  def creatable_relationships
    %i[]
    # %i[
    #  country
    #  ip_country
    # ]
  end

  def permitted_filters
    %i[]
    # %i[
    #  main_group_id
    #  sub_group_id
    # ]
  end

  def permanent_filters
    {}
    # {
    #   public: true
    # }
  end

  def permitted_includes
    %i[]
    # %i[
    #   related_articles
    #   related_products
    #   related_products.main_group
    #   translations
    # ]
  end

  # def after_create(lead)
  #   PostLeadToSlackJob.perform_later lead
  # end

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
    resources = model_class.all

    # Then we reduce this collection with the permanent and requested filters.
    # We could remove all unwanted characters to avoid injection.
    # value.gsub!(/[^0-9A-Za-z]/, '')
    filters&.each do |key, value|
      # If the query does not contain a "*", then do an exact search.
      resources = resources.where("#{key}": value) if value.exclude? '*'

      # If the query contains a "*" then do a fuzzy search.
      # We use Postrgress match operators to search:
      # https://www.postgresql.org/docs/9.6/functions-matching.html#FUNCTIONS-POSIX-TABLE
      resources = resources.where("#{key} ~* ?", value.gsub!('*', '')) if value.include? '*'
    end

    # Here we prepare the options we can pass to the serializers.
    options = {
      params: params.as_json
    }

    # Most importantly, we define which related models to include in the request.
    options[:include] = strong_includes if strong_includes

    # We create a JSON response from the records we collected using the fast and
    # JSON API compliant Netflux serializers.
    json = serializer_class.new(resources, options).serialized_json

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
  #   user_can_serve_one_by_id
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
  # def allow_show
  #   return find_by_id if uuid? params[:id]
  #
  #   find_by_slug
  # end

  # def find_by_id
  #   record = model_class.find_by id: params[:id]
  #
  #   serve_one record
  # end

  # def find_by_slug
  #   record = model_class.find_by slug: params[:id]
  #
  #   serve_one record
  # end

  # def uuid?(string)
  #   /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/.match(string)
  # end

  def allow_show
    return record_not_found if record.nil?
    return error_forbidden_includes if forbidden_includes.any?

    options = {
      params: params.as_json
    }

    options[:include] = strong_includes if strong_includes
    json = serializer_class.new(record, options).serialized_json

    render status: 200, json: json
  end

  # The primary key is not always "id", sometimes it's "slug" or "path".
  # resource = model_class.find_by "#{primary_key}": params[:id]
  # resource = model_class.find_by id: params[:id]
  #
  def primary_key
    model_class.primary_key
  end

  # Returns the record param ID
  # Get /products/IF-2005M
  # Would yield ID "IF-2005M" and the primary key on products has the key "slug", not "id"
  #
  def record
    model_class.find_by "#{primary_key}": params[:id]
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
    return [] unless params[:include]

    params[:include]
      .split(',')
      .collect { |item| item.underscore.to_sym }
  end

  def forbidden_includes
    requested_includes.reject { |x| permitted_includes.include? x }
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
  # On the front-end, when using Ember with JSON API serializers:
  #
  # this.store.query('product', {
  #   filter: { foo: 'thing', bar: true }
  # });
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
    resource = model_class.new(attributes_and_relationships)
    if resource.save!
      after_create
      json = serializer_class.new(resource).serialized_json
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
    # In case only relationships are being updated, no attributes are included in the request
    return {} if params[:data][:attributes].nil?

    # When no attributes are marked as updatable
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
    # In case only attributes are being updated, no relationships are included in the request
    return {} if params[:data][:relationships].nil?

    # When no relationships are marked as updatable
    return {} if creatable_relationships.empty?

    # params['data']['relationships']
    # First we convert the array into  we convert `relationships` into a nested array like:
    # [[:main_category, "d6461197-e618-5502-95a5-1e171f8f71e9"], [:sub_category, "8147cd48-12b6-500e-a001-d80288d644f1"]]
    # The keys are underscored for later use when creating / updating the resource.
    # The values are strong IDs grabbed from the JSON API structured package.

    # TODO: all permitted relationships are being updated with nil if only one relationship is being asked for update

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
    return record_not_found if record.nil?
    return nothing_to_update if attributes_and_relationships.empty?
    return forbidden_attribute if forbidden_attributes.any?

    if record.update!(attributes_and_relationships)
      json = serializer_class.new(record).serialized_json
      render status: 204, json: json
    else
      render status: 422, json: json_errors(record)
    end
  end

  def forbidden_attributes
    return [] if params[:data][:attributes].nil?

    params[:data][:attributes].keys.reject { |attr| creatable_attributes.include? attr.to_sym }
  end

  # DELETING
  #
  # DELETE /products/:uuid
  #
  # def destroy
  #   allow_destroy
  # end
  #
  def allow_destroy
    resource = model_class.find_by id: params[:id]

    return record_not_found if resource.nil?

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
  def after_create
    nil
  end

  # VALIDATION

  def check_content_type
    wrong_content_type unless request.content_type == 'application/vnd.api+json'
  end

  # ERRORS

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

  def error_forbidden_includes
    render_error(
      403,
      'forbidden-includes',
      "The following includes are forbidden: #{forbidden_includes.join(', ')}. Please include them in the API controller or remove them from the request URL."
    )
  end

  def forbidden_filter
    render_error(
      403,
      'forbidden-filter',
      'One of the filters params in the URL is not allowed. Please review.'
    )
  end

  def forbidden_attribute
    render_error(
      403,
      'forbidden-attribute',
      "The following attributes are forbidden: #{forbidden_attributes.join(', ')}. Please include them in the API controller or remove them from the request payload."
    )
  end

  def nothing_to_update
    render_error(
      400,
      'nothing-to-update',
      'The payload is empty and thus there is nothing to update. To resolve: add attributes or relationships to the request payload.'
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

  def record_not_found(meta = nil)
    render_error(
      422,
      'record-not-found',
      'No record was found with the given ID.',
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
