module Public
  class ProductCategoriesController < ApplicationController
    # Return all product categories
    # GET /public/product-categories
    # GET /public/product-categories?filter[parent_category]=:slug
    def index
      return show if params[:slug]
      categories = ProductCategory.all.order('name_plural desc')
      categories = categories.parent_category(category) if category.present?
      render status: 200, json: json_resources(Public::ProductCategoryResource, categories)
    end

    # Return product category with slug
    # Return product category with ID
    # GET /public/product-categories/?slug=:slug
    # GET /public/product-categories/:id
    def show
      category = ProductCategory.find_by_slug(params[:slug]) if params[:slug]
      category = ProductCategory.find_by_id(params[:id]) if params[:id]
      return not_found unless category.present?
      render status: 200, json: json_resource(Public::ProductCategoryResource, category)
    end

    private

    def filter
      params.require(:filter) if params['filter']
    end

    def category
      filter['product-category'] if filter
    end

    def not_found
      json_error(422, 'product-category-not-found', 'No product category with this ID / slug was found.')
    end
  end
end
