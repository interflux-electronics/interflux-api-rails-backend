module Admin
  class ProductsController < Admin::AuthenticatedController
    # Return all products
    # GET /admin/products
    def index
      return show if params[:slug]
      products = Product.all
      json = Admin::ProductSerializer.new(products).serialized_json
      render status: 200, json: json
    end

    # Return product by ID
    # Return product by slug
    # GET /admin/products/:id
    # GET /admin/products/?slug=:slug
    def show
      product = Product.find_by_slug(params[:slug]) if params[:slug]
      product = Product.find_by_id(params[:id]) if params[:id]
      return resource_not_found if product.nil?
      json = Admin::ProductSerializer.new(product).serialized_json
      render status: 200, json: json
    end

    # Create a product
    # POST /admin/products
    def create
      product = Product.new(permitted_attributes)
      product.main_category_id = main_category
      product.sub_category_id = sub_category
      if product.save!
        json = Admin::ProductSerializer.new(product).serialized_json
        render status: 201, json: json
      else
        render status: 422, json: json_errors(product)
      end
    end

    # Update a product
    # PUT /admin/products/:id
    def update
      product = Product.find_by_id(params[:id])
      return resource_not_found if product.nil?
      product.assign_attributes(permitted_attributes)
      product.main_category_id = main_category
      product.sub_category_id = sub_category
      if product.save!
        json = Admin::ProductSerializer.new(product).serialized_json
        render status: 204, json: json
      else
        render status: 422, json: json_errors(product)
      end
    end

    # Delete a product
    # DELETE /admin/products/:id
    def destroy
      product = Product.find_by_id(params[:id])
      return resource_not_found if product.nil?
      product.destroy
      head 204
    end

    private

    def permitted_attributes
      params.require(:data)
            .require(:attributes)
            .permit(
              :name,
              :slug,
              :public,
              :pitch,
              :body
            )
    end

    def relationships
      params.require(:data).require(:relationships)
    end

    def main_category
      relationships[:'main-category']['data']['id']
    end

    def sub_category
      relationships[:'sub-category']['data']['id']
    end
  end
end
