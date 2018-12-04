module JsonApi
  extend ActiveSupport::Concern

  # Below we make sure all controller actions return a JSON API compliant
  # 403 forbidden, unless overwritten by the controller invoking this concern.

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

  # Return an array of resource
  # GET /namespace/route
  # GET /namespace/?filter={key:value,key:value}
  def user_can_fetch_all
    return show if params[:slug]

    # TODO: Don't use all, allow for always filter
    resources = resource_klass.all
    strong_filters&.each do |key, value|
      resources = resources.where("#{key.underscore}": value)
    end
    options = {}
    options[:include] = strong_includes if strong_includes
    json = serializer_klass.new(resources, options).serialized_json
    render status: 200, json: json
  end

  # Return a single resource
  # GET /namespace/route/:uuid
  # GET /namespace/route/:slug
  # Note: For humans and SEO we avoid embedding UUIDs in URLs. Instead we use
  # hyphenated strings referred to as slugs. These slugs are the only bit of
  # information the front-end can send to the API to fetch a resource. Given
  # these are unique in every table, we can use them for for finding resources
  # just like we would with an :uuid.
  # def show
  #   resource = resource_klass.find_by_id(params[:id]) if params[:id]
  #   resource = resource_klass.find_by_slug(params[:slug]) if params[:slug]
  #   return resource_not_found if resource.nil?
  #   options = {}
  #   options[:include] = strong_includes if strong_includes
  #   json = serializer_klass.new(resource, options).serialized_json
  #   render status: 200, json: json
  # end
  #
  def user_can_fetch_one_by_id_or_slug
    return user_can_fetch_one_by_slug if params[:slug]

    user_can_fetch_one_by_id
  end

  def user_can_fetch_one_by_id
    resource = resource_klass.find_by id: params[:id]

    user_can_fetch_one resource
  end

  def user_can_fetch_one_by_slug
    resource = resource_klass.find_by slug: params[:slug]

    user_can_fetch_one resource
  end

  def user_can_fetch_one(resource)
    return resource_not_found if resource.nil?

    options = {}
    options[:include] = strong_includes if strong_includes
    json = serializer_klass.new(resource, options).serialized_json
    render status: 200, json: json
  end

  # Create a resource
  # POST /namespace/resources, params { foo: bar }
  def user_can_create
    resource = resource_klass.new(attributes_and_relationships)
    if resource.save!
      after_create(resource)
      json = serializer_klass.new(resource).serialized_json
      render status: 201, json: json
    else
      render status: 422, json: json_errors(resource)
    end
  end

  private

  def attributes_and_relationships
    strong_attributes
      .merge(strong_relationships)
  end

  # Allow only predifined list of attributes that can saved to the resource
  def strong_attributes
    return {} if attributes.empty?

    params
      .require(:data)
      .require(:attributes)
      .permit(attributes)
  end

  # Return a hash of permitted relationship and strong IDs pulled from the params.
  # Usage: Make sure each controller has a similar array:
  # ```
  # def relationships
  #   %i[
  #     main_category
  #     sub_category
  #   ]
  # end
  # ```
  def strong_relationships
    # TODO: Clean up this mess
    params['data']['relationships']
    # First we convert the array into  we convert `relationships` into a nested array like:
    # [[:main_category, "d6461197-e618-5502-95a5-1e171f8f71e9"], [:sub_category, "8147cd48-12b6-500e-a001-d80288d644f1"]]
    # The keys are underscored for later use when creating / updating the resource.
    # The values are strong IDs grabbed from the JSON API structured package.
    nested_array = relationships.collect do |key|
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

  def strong_filters
    return unless params[:filter]

    json_keys = filters.collect(&:to_s)
    # Before Olive Branch:
    # json_keys = filters.collect { |item| item.to_s.dasherize }
    params
      .require(:filter)
      .permit(json_keys)
      .to_hash
  end

  def strong_includes
    return unless params[:include]

    arr = params[:include]
          .split(',')
          .collect { |item| item.parameterize.underscore.to_sym }
    # Intersect both arrays so we only keep the param include keys that are also defined in the controller.
    includes && arr
  end

  # Render a JSON API response Netlflix' Fast JSON API Serializers
  # https://github.com/Netflix/fast_jsonapi
  # Example: render_response(200, product, Admin::ProductSerializer)
  def render_response(status, record, serializer)
    json = serializer.new(record).serialized_json
    render status: status, json: json
  end

  def after_create
    nil
  end

  # def uuid_regex
  #   /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/
  # end
  #
  # def valid_uuid?(uuid)
  #   uuid_regex.match?(uuid.to_s.downcase)
  # end
end
