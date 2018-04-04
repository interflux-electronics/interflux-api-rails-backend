module Admin
  class BaseController < Admin::AuthenticatedController
    # Return all resources
    # GET /admin/resources
    # Return all filtered resources
    # GET /admin/resources?filter[active:true]
    def index
      return show if params[:slug]
      resources = model_class.all
      json = serializer_class.new(resources).serialized_json
      render status: 200, json: json
    end

    # Return resource by ID
    # Return resource by slug
    # GET /admin/resources/:id
    # GET /admin/resources/?slug=:slug
    def show
      resource = model_class.find_by_slug(params[:slug]) if params[:slug]
      resource = model_class.find_by_id(params[:id]) if params[:id]
      return resource_not_found if resource.nil?
      json = serializer_class.new(resource).serialized_json
      render status: 200, json: json
    end

    # Create a resource
    # POST /admin/resources
    def create
      resource = model_class.new(attributes)
      if resource.save
        json = serializer_class.new(resource).serialized_json
        render status: 201, json: json
      else
        render_error(422, 'could-not-save', resource.errors.full_messages[0])
      end
    end

    # Update a resource
    # PUT /admin/resources/:id
    def update
      record = model_class.find_by_id(params[:id]) || resource_not_found
      # return resource_not_found if record.nil?
      if record.update(attributes)
        render_response(204, record, serializer_class)
      else
        render_error(422, 'could-not-save', record.errors.full_messages[0])
      end
    end

    # Delete a resource
    # DELETE /admin/resources/:id
    def destroy
      resource = model_class.find_by_id(params[:id])
      return resource_not_found if resource.nil?
      resource.destroy

      # TODO: also destroy everything related and dependent on this resource

      head 204
    end

    private

    # Define the commented out blocks below in each controller that inherits this base controller

    # def model_class
    #   Product
    # end

    # def serializer_class
    #   Admin::ProductSerializer
    # end

    # def attributes
    #   params
    #     .require(:data)
    #     .require(:attributes)
    #     .permit(
    #       :url,
    #       :width,
    #       :height
    #     )
    #     .merge(relationships)
    # end

    # def relationships
    #   {
    #     image_id: relationship('image')[:id],
    #   }
    # end

    def relationship(key)
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
  end
end
