# frozen_string_literal: true

module Admin
  class ProductsController < ApplicationController
    def index
      byebug
      @products = Product.where(visible: true)
      render json: JSONAPI::ResourceSerializer.new(ProductResource).serialize_to_hash(ProductResource.new(@products, nil))
    end
    def show
      byebug
      product = Product.find(params[:id])
      render json: JSONAPI::ResourceSerializer.new(Admin::ProductResource).serialize_to_hash(ProductResource.new(product, nil))
    end
    # POST /todos/:todo_id/items
    def create
      byebug
      @todo.items.create!(item_params)
      json_response(@todo, :created)
    end

    # PUT /todos/:todo_id/items/:id
    def update
      byebug
      @item.update(item_params)
      head :no_content
    end

    # DELETE /todos/:todo_id/items/:id
    def destroy
      byebug
      @item.destroy
      head :no_content
    end
  end
end
