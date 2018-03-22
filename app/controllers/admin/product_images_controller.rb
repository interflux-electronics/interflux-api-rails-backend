module Admin
  class ProductImagesController < Admin::AuthenticatedController
    before_action :find_images, only: %i[index]
    before_action :find_image, only: %i[show update destroy]

    # Return all images
    # Return all images of 1 product
    # GET /admin/images
    # GET /admin/images?filter[type:Product, id:123]
    def index
      render status: 200, json: Admin::ImageSerializer.new(@images).serialized_json
    end

    # Return image with ID
    # GET /admin/images/:id
    def show
      render status: 200, json: Admin::ImageSerializer.new(@image).serialized_json
    end

    # Create a image
    # POST /admin/images
    def create
      @image = Image.new(attributes)
      return no_image_owner unless relationships && image_owner_id && image_owner_type
      @image.image_owner_id = image_owner_id
      @image.image_owner_type = image_owner_type
      if @image.save!
        render status: 201, json: Admin::ImageSerializer.new(@image).serialized_json
      else
        render status: 422, json: json_errors(image)
      end
    end

    # Update a image
    # PUT /admin/images/:id
    def update
      @image.assign_attributes(attributes)
      @image.image_owner_id = image_owner_id
      @image.image_owner_type = image_owner_type
      if @image.save!
        render status: 204, json: Admin::ImageSerializer.new(@image).serialized_json
      else
        render status: 422, json: json_errors(@image)
      end
    end

    # Delete a image
    # DELETE /admin/images/:id
    def destroy
      @image.destroy
      head 204
    end

    private

    def find_image
      @image = Image.find_by_id(params[:id])
      return not_found if @image.nil?
    end

    def find_images
      return @images = Image.all unless filter_type && filter_id
      @images = Image
                .where(image_owner_type: filter_type)
                .where(image_owner_id: filter_id)
    end

    def attributes
      params.require(:data)
            .require(:attributes)
            .permit(
              :alt
            )
    end

    def relationships
      params.require(:data).require(:relationships)
    end

    def product_id
      relationships[:product]['data']['id']
    end

    def filter
      params.require(:filter) if params['filter']
    end

    def filter_type
      filter[:type] if filter
    end

    def filter_id
      filter[:id] if filter
    end

    def not_found
      json_error(422, 'image-not-found', 'No image with this ID was found.')
    end

    def no_image_owner
      json_error(422, 'no-image-owner', 'No image owner is defined on this request.')
    end
  end
end
