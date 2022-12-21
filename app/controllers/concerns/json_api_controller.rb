# TODO: Tackle N+1 queries by enabling .include()
# https://medium.com/@codenode/10-tips-for-eager-loading-to-avoid-n-1-queries-in-rails-2bad54456a3f

# This module centralises all logic needed to adhere to the JSON API spec.
# https://jsonapi.org/
module JsonApiController
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
    return error_forbidden_filters if forbidden_filters.any?

    # First we gather all records of the model class.
    resources = model_class.all

    # Next we reduce this collection with the permanent and requested filters.
    #
    # Each filter consist of a key and value pair.
    # If the value has a valid POSIX prefix.
    # Because we use Postgres we can use POSIX regexes instead of LIKE and SIMILAR TO.
    # https://www.postgresql.org/docs/9.6/functions-matching.html#FUNCTIONS-POSIX-TABLE
    #
    #       omit prefix for exact match
    # ~     match regex, case sensitive
    # ~*    match regex, case insensitive
    # !~    does not match regex, case sensitive
    # !~*   does not match regex, case insensitive
    #
    # TODO: We could remove all unwanted characters to avoid injection
    # value.gsub!(/[^0-9A-Za-z]/, '')
    #
    filters&.each do |key, value|
      prefix = /^!?~\*?/.match(value).to_s if value.is_a? String

      resources = if prefix.present?
                    resources.where("#{key} #{prefix} ?", value.gsub!(prefix, ''))
                  else
                    resources.where("#{key}": value)
                  end
    end

    # Here we prepare the options we can pass to the serializers.
    options = {
      params: params.as_json
    }

    # Most importantly, we define which related models to include in the request.
    options[:include] = strong_includes if strong_includes

    puts 'XXXXXX'
    puts permitted_includes

    # We create a JSON response from the records we collected using the fast and
    # JSON API compliant Netflux serializers.
    json = serializer_class.new(resources, options).serializable_hash.to_json

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

    json = serializer_class.new(record, options).serializable_hash.to_json

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

  # Returns array of requested filter keys.
  def requested_filter_keys
    return [] unless params[:filter]

    JSON.parse(params[:filter].to_json).map { |k, _v| k.to_sym }
  end

  def forbidden_filters
    requested_filter_keys.reject { |x| permitted_filters.include? x }
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
      after_create resource
      json = serializer_class.new(resource).serializable_hash.to_json
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
  #
  # Typical attribute payload:
  # {
  #   "data": {
  #     "id": "IF-2005M",
  #     "attributes": {
  #       "label": "a"
  #     },
  #     "type": "products"
  #   }
  # }
  #
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
  # Typical relationships:
  # {
  #   "data": {
  #     "id": "IF-2005M",
  #     "relationships": {
  #       "product-family": {
  #         "data": {
  #           "type": "product-families",
  #           "id": "soldering-fluxes"
  #         }
  #       }
  #     },
  #     "type": "products"
  #   }
  # }
  #
  # TODO: Was able to create product whereas creatable_relationships did not include it...
  #
  def strong_relationships
    relationships = params[:data][:relationships]

    # In case only attributes are being updated, no relationships are included in the request
    return {} if relationships.nil?

    # When no relationships are marked as updatable
    return {} if creatable_relationships.empty?

    # First we permit the all creatable relationships.
    # { product: { data: [:id, :type] }, product_family: { data: [:id, :type] } }
    expected_json = {}
    creatable_relationships.each { |x| expected_json[x] = { data: %i[id type] } }
    params.require(:data).require(:relationships).permit(expected_json)

    # Secondly we create the hash we need to update the database
    # { "product_id": "IF-2005M", "family_id": "soldering-fluxes" }
    # Gotcha: the data payload will be nil when removing a relationship
    hash = {}
    relationships.each_key { |x| hash["#{x}_id"] = relationships[x][:data] ? relationships[x][:data][:id] : nil }
    hash
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
    return forbidden_attribute if forbidden_attributes.any?
    return forbidden_relationship if forbidden_relationships.any?
    return nothing_to_update if attributes_and_relationships.empty?

    if record.update!(attributes_and_relationships)
      json = serializer_class.new(record).serializable_hash.to_json
      render status: 204, json: json
    else
      render status: 422, json: json_errors(record)
    end
  end

  def forbidden_attributes
    return [] if params[:data][:attributes].nil?

    params[:data][:attributes].keys.reject { |attr| creatable_attributes.include? attr.to_sym }
  end

  def forbidden_relationships
    return [] if params[:data][:relationships].nil?

    params[:data][:relationships].keys.reject { |attr| creatable_relationships.include? attr.to_sym }
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
    record.destroy

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
  def after_create(_resource)
    nil
  end

  # VALIDATION

  # Check for the JSON API Content Type header. Throw 415 error if not present.
  # Firefox has a known bug where they append "; charset=UTF-8" to the end, which breaks.
  # https://josef.codes/firefox-adds-charset-utf-8-when-doing-post-requests-with-ajax/
  def check_content_type
    wrong_content_type unless request.content_type.present? && request.content_type.split(';').first == 'application/vnd.api+json'
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

  def error_forbidden_filters
    render_error(
      403,
      'forbidden-filters',
      "The following includes are forbidden: #{forbidden_filters.join(', ')}. Please include them in the API controller or remove them from the request URL."
    )
  end

  def forbidden_attribute
    render_error(
      403,
      'forbidden-attribute',
      "The following attributes are forbidden: #{forbidden_attributes.join(', ')}. Please include them in the API controller or remove them from the request payload."
    )
  end

  def forbidden_relationship
    render_error(
      403,
      'forbidden-relationship',
      "The following relationships are forbidden: #{forbidden_relationships.join(', ')}. Please include them in the API controller or remove them from the request payload."
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
