module Admin
  class ProductTranslationsController < Admin::AuthenticatedController
    # Fetch all translations for one particular product.
    # There is no user cases for fetching ALL translations, so it's forbidden.
    # GET /admin/product-translations?slug=:product_slug
    def index
      slug = params[:slug]
      return missing_slug unless slug
      product = Product.find_by_slug(slug)
      return unknown_slug(slug) if product.nil?
      translations = ProductTranslation.where(product: product)
      json = Admin::ProductTranslationSerializer.new(translations).serialized_json
      render status: 200, json: json
    end

    # Return a single product translation by ID
    # GET /admin/product-translations/:id
    def show
      translation = ProductTranslation.find_by_id(params[:id])
      return resource_not_found if translation.nil?
      json = Admin::ProductTranslationSerializer.new(translation).serialized_json
      render status: 200, json: json
    end

    # Create a product translation
    # POST /admin/product-translations
    def create
      translation = ProductTranslation.new(attributes)
      translation.product_id = product_id
      translation.language_id = language_id
      if translation.save!
        json = Admin::ProductTranslationSerializer.new(translation).serialized_json
        render status: 201, json: json
      else
        render status: 422, json: json_errors(translation)
      end
    end

    # Update a product translation
    # PUT /admin/product-translations/:id
    def update
      translation = ProductTranslation.find_by_id(params[:id])
      return resource_not_found if translation.nil?
      translation.assign_attributes(attributes)
      translation.product_id = product_id
      translation.language_id = language_id
      if translation.save!
        json = Admin::ProductTranslationSerializer.new(translation).serialized_json
        render status: 204, json: json
      else
        render status: 422, json: json_errors(translation)
      end
    end

    # Delete a product translation
    # DELETE /admin/product-translations/:id
    def destroy
      translation = ProductTranslation.find_by_id(params[:id])
      return resource_not_found if translation.nil?
      translation.destroy
      head 204
    end

    private

    def attributes
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
