module Admin
  class ProductImagesController < Admin::AuthenticatedController
    # Return all product images
    # Return all all images belonging to a single product
    # GET /admin/images
    # GET /admin/images?filter[product_id:123]
    def index
      images = Image.for_products
      images = images.for_owner(product_id) if product_id
      render status: 200, json: Admin::ImageSerializer.new(images).serialized_json
    end

    # Return a single product image by ID
    # GET /admin/product-images/:id
    def show
      image = Image.find_by_id(params[:id])
      return resource_not_found if image.nil?
      render status: 200, json: Admin::ImageSerializer.new(image).serialized_json
    end

    # Create a product image
    # POST /admin/product-images
    def create
      image = Image.new(attributes)
      image.image_owner_type = 'Product'
      image.image_owner_id = relationships['product']['data']['id']
      if image.save!
        render status: 201, json: Admin::ImageSerializer.new(image).serialized_json
      else
        render status: 422, json: json_errors(image)
      end
    end

    # Update a product image
    # PUT /admin/product-images/:id
    def update
      image = Image.find_by_id(params[:id])
      return resource_not_found if image.nil?
      image.assign_attributes(attributes)
      image.image_owner_type = 'Product'
      image.image_owner_id = relationships['product']['data']['id']
      if image.save!
        render status: 204, json: Admin::ImageSerializer.new(image).serialized_json
      else
        render status: 422, json: json_errors(image)
      end
    end

    # Delete a product image
    # DELETE /admin/product-images/:id
    def destroy
      image = Image.find_by_id(params[:id])
      return resource_not_found if image.nil?
      image.destroy
      head 204
    end

    private

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

    def filter
      params.require(:filter) if params['filter']
    end

    def product_id
      filter['product-id'] if filter
    end

    def no_image_owner
      json_error(422, 'no-image-owner', 'No image owner is defined on this request.')
    end
  end
end
