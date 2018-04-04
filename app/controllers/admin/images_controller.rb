module Admin
  class ImagesController < Admin::BaseController
    def index
      forbidden
    end

    def show
      super
    end

    def create
      super
    end

    def update
      super
    end

    def destroy
      super
    end

    private

    def model_class
      Image
    end

    def serializer_class
      Admin::ImageSerializer
    end

    def attributes
      params
        .require(:data)
        .require(:attributes)
        .permit(
          :alt
        )
        .merge(relationships)
    end

    def relationships
      {}
    end
  end
end

# module Admin
#   # class ImagesController < Admin::AuthenticatedController
#   class ImagesController < Admin::BaseController
#     # Return all product images
#     # Return all all images belonging to a single product
#     # GET /admin/images
#     # GET /admin/images?filter[product_id:123]
#     def index
#       images = Image.all
#       images = images.for(owner_type, owner_id) if owner_type && owner_id
#       render status: 200, json: Admin::ImageSerializer.new(images).serialized_json
#     end
#
#     # Return a single product image by ID
#     # GET /admin/images/:id
#     def show
#       image = Image.find_by_id(params[:id])
#       return resource_not_found if image.nil?
#       render status: 200, json: Admin::ImageSerializer.new(image).serialized_json
#     end
#
#     # Create a product image
#     # POST /admin/images
#     def create
#       image = Image.new(image_attributes)
#       if relationships['product']
#         image.image_owner_type = 'Product'
#         image.image_owner_id = relationships[:product]['data']['id']
#       end
#       if image.save!
#         render status: 201, json: Admin::ImageSerializer.new(image).serialized_json
#       else
#         render status: 422, json: json_errors(image)
#       end
#     end
#
#     # Update a product image
#     # PUT /admin/images/:id
#     def update
#       image = Image.find_by_id(params[:id])
#       return resource_not_found if image.nil?
#       image.assign_attributes(image_attributes)
#       if relationships['product']
#         image.image_owner_type = 'Product'
#         image.image_owner_id = relationships[:product]['data']['id']
#       end
#       if image.save!
#         render status: 204, json: Admin::ImageSerializer.new(image).serialized_json
#       else
#         render status: 422, json: json_errors(image)
#       end
#     end
#
#     # Delete a product image
#     # DELETE /admin/images/:id
#     def destroy
#       image = Image.find_by_id(params[:id])
#       return resource_not_found if image.nil?
#       image.destroy
#       head 204
#     end
#
#     private
#
#     def image_attributes
#       params.require(:data)
#             .require(:attributes)
#             .permit(
#               :alt
#             )
#     end
#
#     def relationships
#       params.require(:data).require(:relationships)
#     end
#
#     def filter
#       params.require(:filter) if params['filter']
#     end
#
#     def owner_type
#       filter['type'] if filter
#     end
#
#     def owner_id
#       filter['id'] if filter
#     end
#
#     def no_image_owner
#       render_error(422, 'no-image-owner', 'No image owner is defined on this request.')
#     end
#   end
# end
