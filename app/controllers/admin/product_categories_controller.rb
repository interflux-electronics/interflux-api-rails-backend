module Admin
  class ProductCategoriesController < Admin::AuthenticatedController
    # Return all product categories
    # GET /public/product-categories
    # GET /public/product-categories?filter[parent_category]=:slug
    def index
      categories = ProductCategory.all.order('name_plural desc')
      render status: 200, json: json_resources(Public::ProductCategoryResource, categories)
    end

    # Return product category with slug
    # Return product category with ID
    # GET /public/product-categories/?slug=:slug
    # GET /public/product-categories/:id
    def show
      category = ProductCategory.find_by_id(params[:id])
      return not_found unless category.present?
      render status: 200, json: json_resource(Public::ProductCategoryResource, category)
    end

    private

    def not_found
      json_error(422, 'product-category-not-found', 'No product category with this ID / slug was found.')
    end
  end
end
