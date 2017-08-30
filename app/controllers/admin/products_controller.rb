# frozen_string_literal: true

module Admin
  class ProductsController < ApplicationController
    before_action :set_product, only: %i[update destroy]

    # GET /admin/products
    def index
      process_request # Default to JSON API Resources controller
    end

    # GET /admin/products/:id
    def show
      process_request # Default to JSON API Resources controller
    end

    # POST /admin/products
    def create
      product = Product.create!(product_params)
      json = JSONAPI::ResourceSerializer.new(Admin::ProductResource).serialize_to_hash(Admin::ProductResource.new(product, nil))
      render json: json, status: 201
    end

    # PUT /admin/products/:id
    def update
      @product.update(product_params)
      head 204
    end

    # DELETE /admin/products/:id
    def destroy
      @product.destroy
      head 204
    end

    private

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:data)
            .require(:attributes)
            .permit(
              :name,
              :slug,
              :visible,
              :product_type,
              :pitch,
              :corpus
            )
    end
  end
end
