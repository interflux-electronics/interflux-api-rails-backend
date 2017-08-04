# frozen_string_literal: true

class Admin::ProductsController < ApplicationController
  before_action :set_product, only: %i[show update destroy]

  # GET /admin/products
  def index
    @products = Product.all
    json_response(@products)
  end

  # POST /admin/products
  def create
    @product = Product.create!(product_params)
    json_response(@product, :created)
  end

  # GET /admin/products/:id
  def show
    json_response(@product)
  end

  # PUT /admin/products/:id
  def update
    @product.update(product_params)
    head :no_content
  end

  # DELETE /admin/products/:id
  def destroy
    @product.destroy
    head :no_content
  end

  private

  def product_params
    params.permit(
      :name,
      :slug,
      :image_url,
      :teaser,
      :corpus
    )
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
