module Admin
  class ProductTranslationsController < Admin::AuthenticatedController
    before_action :find_resource, only: %i[index show update destroy]

    # Return all products
    # GET /admin/product-translations
    def index
      return forbidden unless params[:product]
      translations = ProductTranslation.where(product_id: params[:product])
      render status: 200, json: json_resources(Admin::ProductTranslationResource, translations)
    end

    # Return product with ID
    # GET /admin/product-translations/:id
    def show
      render status: 200, json: json_resource(Admin::ProductTranslationResource, @translation)
    end

    # Create a product
    # POST /admin/product-translations
    def create
      translation = ProductTranslation.new(permitted_attributes)
      translation.product_id = product_id
      translation.language_id = language_id
      if translation.save!
        render status: 201, json: json_resource(Admin::ProductTranslationResource, translation)
      else
        render status: 422, json: json_errors(translation)
      end
    end

    # Update a product
    # PUT /admin/product-translations/:id
    def update
      @translation.assign_attributes(permitted_attributes)
      @translation.product_id = product_id
      @translation.language_id = language_id
      if @translation.save!
        render status: 204, json: json_resource(Admin::ProductTranslationResource, @translation)
      else
        render status: 422, json: json_errors(@translation)
      end
    end

    # Delete a product translation
    # DELETE /admin/product-translations/:id
    def destroy
      @translation.destroy
      head 204
    end

    private

    def find_resource
      @translation = ProductTranslation.find_by_id(params[:id]) if params[:id]
      return not_found if @translation.nil? && params[:id]
    end

    def permitted_attributes
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
      relationships[:'product']['data']['id']
    end

    def language_id
      relationships[:'language']['data']['id']
    end

    def not_found
      json_error(422, 'product-translation-not-found', 'No product translation with this ID was found.')
    end
  end
end
