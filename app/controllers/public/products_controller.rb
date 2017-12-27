module Public
  class ProductsController < ApplicationController
    # Return all products
    # Optionally filter per main category
    # Optionally filter per sub category
    # GET /public/products/?filter[main-category]=:slug
    # GET /public/products/?filter[sub-category]=:slug
    def index
      return show if params[:slug]
      products = Product.which_are_public.order('name desc')
      products = products.where_main_category(main_category) if main_category.present?
      products = products.where_sub_category(sub_category) if sub_category.present?
      render status: 200, json: json_resources(Public::ProductResource, products)
    end

    # Return product with slug
    # Return product with ID
    # GET /public/products/?slug=:slug
    # GET /public/products/:id
    def show
      product = Product.find_by_slug(params[:slug]) if params[:slug]
      product = Product.find_by_id(params[:id]) if params[:id]
      return not_found unless product.present?
      render status: 200, json: json_resource(Public::ProductResource, product)
    end

    private

    def filter
      params.require(:filter) if params['filter']
    end

    def main_category
      filter['main-category'] if filter
    end

    def sub_category
      filter['sub-category'] if filter
    end

    def not_found
      json_error(422, 'product-not-found', 'No product with this ID / slug was found.')
    end
  end
end
