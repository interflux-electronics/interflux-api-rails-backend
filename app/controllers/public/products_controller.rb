# frozen_string_literal: true

module Public
  class ProductsController < ApplicationController
    # GET /public/products
    def index
      @slug = params['slug']
      return show_by_slug(@slug) if @slug.present?
      @product_type = params['product_type']
      @products = Product.where(public: true)
      @products = @products.where(product_type: @product_type) if @product_type.present?
      @product_resources = @products.map { |product| ProductResource.new(product, nil) }
      render json: JSONAPI::ResourceSerializer.new(ProductResource).serialize_to_hash(@product_resources)
    end

    # GET /public/products?slug=:slug
    def show_by_slug(slug)
      @product = Product.where(public: true).find_by(slug: slug)
      if @product.present?
        @json = JSONAPI::ResourceSerializer.new(Public::ProductResource).serialize_to_hash(Public::ProductResource.new(@product, nil))
        render json: @json, status: 200
      else
        render status: 422, json: { error: "Could not find product with slug \"#{slug}\"." }
      end
    end
  end
end
