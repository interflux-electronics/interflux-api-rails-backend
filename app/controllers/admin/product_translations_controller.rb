module Admin
  class ProductTranslationsController < Admin::AuthenticatedController
    before_action :find_resource, only: %i[show update destroy]

    # Fetch all translations for one particular product
    # GET /admin/product-translations?slug=:product_slug
    def index
      slug = params[:slug]
      return missing_slug unless slug
      product = Product.find_by_slug(slug)
      return unknown_slug(slug) if product.nil?
      translations = ProductTranslation.where(product: product)
      render status: 200, json: json_resources(Admin::ProductTranslationResource, translations)
    end

    # Return a single product translation by ID
    # GET /admin/product-translations/:id
    def show
      render status: 200, json: json_resource(Admin::ProductTranslationResource, @resource)
    end

    # Create a product translation
    # POST /admin/product-translations
    def create
      resource = ProductTranslation.new(resource_attributes)
      resource.product_id = product_id
      resource.language_id = language_id
      if resource.save!
        render status: 201, json: json_resource(Admin::ProductTranslationResource, resource)
      else
        render status: 422, json: json_errors(resource)
      end
    end

    # Update a product translation
    # PUT /admin/product-translations/:id
    def update
      @resource.assign_attributes(resource_attributes)
      @resource.product_id = product_id
      @resource.language_id = language_id
      if @resource.save!
        render status: 204, json: json_resource(Admin::ProductTranslationResource, @resource)
      else
        render status: 422, json: json_errors(@resource)
      end
    end

    # Delete a product translation
    # DELETE /admin/product-translations/:id
    def destroy
      @resource.destroy
      head 204
    end

    private

    def find_resource
      id = params[:id]
      @resource = ProductTranslation.find_by_id(id)
      return not_found(id) if @resource.nil?
    end

    def resource_attributes
      params.require(:data)
            .require(:attributes)
            .permit(
              :pitch,
              :body
            )
    end

    def relationships
      params.require(:data).require(:relationships)
    end

    def product_id
      relationships[:product]['data']['id']
    end

    def language_id
      relationships[:language]['data']['id']
    end

    def missing_slug
      json_error(422, 'missing-slug', 'This endpoint requires a product slug param.')
    end

    def unknown_slug(slug)
      json_error(422, 'unknown-slug', "No product was found for product slug \"#{slug}\".")
    end

    def not_found(id)
      json_error(422, 'not-found', "No product translation was found for ID \"#{id}\".")
    end
  end
end
