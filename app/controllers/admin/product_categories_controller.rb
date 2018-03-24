module Admin
  class ProductCategoriesController < Admin::AuthenticatedController
    # Return all product categories
    # GET /admin/product-categories
    def index
      categories = ProductCategory.all
      json = Admin::ProductCategorySerializer.new(categories).serialized_json
      render status: 200, json: json
    end

    # Return product category by ID
    # GET /admin/product-categories/:id
    def show
      category = ProductCategory.find_by_id(params[:id])
      return ressource_not_found if category.nil?
      json = Admin::ProductCategorySerializer.new(category).serialized_json
      render status: 200, json: json
    end
  end
end
