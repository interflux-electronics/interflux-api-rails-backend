module Public
  class ProductsController < ApplicationController

    # Return all appointments
    # Optionally filter per group
    # Optionally filter per sub group
    # GET /public/products/?filter[group]=:group
    # GET /public/products/?filter[sub_group]=:sub_group
    def index
      return show if params[:slug]
      products = Product.active.order('name desc')
      products = products.with_group(product_group) if product_group.present?
      # products = products.with_sub_group(sub_group) if sub_group.present?
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

    def product_group
      filter[:product_group] if filter
    end

    def sub_group
      filter[:sub_group]
    end
  end
end
