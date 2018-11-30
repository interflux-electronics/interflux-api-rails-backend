class ProductGroupsController < ApplicationController
  before_action :set_product_group, only: %i[show update destroy]

  # GET /product_groups
  def index
    @product_groups = ProductGroup.all

    render json: @product_groups
  end

  # GET /product_groups/1
  def show
    render json: @product_group
  end

  # POST /product_groups
  def create
    @product_group = ProductGroup.new(product_group_params)

    if @product_group.save
      render json: @product_group, status: :created, location: @product_group
    else
      render json: @product_group.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /product_groups/1
  def update
    if @product_group.update(product_group_params)
      render json: @product_group
    else
      render json: @product_group.errors, status: :unprocessable_entity
    end
  end

  # DELETE /product_groups/1
  def destroy
    @product_group.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product_group
    @product_group = ProductGroup.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def product_group_params
    params.fetch(:product_group, {})
  end
end
