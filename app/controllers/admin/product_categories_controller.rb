module Admin
  class ProductCategoriesController < Admin::AuthenticatedController
    # Return all product categories
    # GET /public/product-categories
    def index
      categories = ProductCategory.all
      json = Admin::ProductCategorySerializer.new(categories).serialized_json
      render status: 200, json: json
    end

    # Return product category by ID
    # GET /public/product-categories/:id
    def show
      category = ProductCategory.find(params[:id])
      return ressource_not_found if category.nil?
      json = Admin::ProductCategorySerializer.new(category).serialized_json
      render status: 200, json: json
    end
  end
end
