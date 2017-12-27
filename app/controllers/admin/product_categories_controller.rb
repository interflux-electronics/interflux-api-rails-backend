module Admin
  class ProductCategoriesController < Admin::AuthenticatedController
    # GET /admin/product_groups
    def index
      @products = ProductCategory.all
      render status: 200, json: json_resources(Admin::ProductCategory, @products)
    end
  end
end
