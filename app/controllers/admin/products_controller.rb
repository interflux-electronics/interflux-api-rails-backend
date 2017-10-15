# frozen_string_literal: true

module Admin
  class ProductsController < Admin::AuthenticatedController
    before_action :set_product, only: %i[show update destroy]

    # GET /admin/products
    def index
      @products = Product.all
      @product_resources = @products.map { |product| ProductResource.new(product, nil) }
      render json: JSONAPI::ResourceSerializer.new(Admin::ProductResource).serialize_to_hash(@product_resources)
    end

    # GET /admin/products/:id
    def show
      json = JSONAPI::ResourceSerializer.new(Admin::ProductResource).serialize_to_hash(Admin::ProductResource.new(@product, nil))
      render json: json, status: 200
    end

    # POST /admin/products
    def create
      @new_product = Product.create!(product_params)
      json = JSONAPI::ResourceSerializer.new(Admin::ProductResource).serialize_to_hash(Admin::ProductResource.new(@new_product, nil))
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
              :public,
              :product_type,
              :pitch,
              :corpus
            )
    end
  end
end
