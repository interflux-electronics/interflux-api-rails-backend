module Admin
  class ProductsController < Admin::AuthenticatedController
    before_action :find_product, only: %i[index show update destroy]

    # Return all products
    # GET /admin/products
    def index
      return show if params[:slug]
      products = Product.all.order('name desc')
      render status: 200, json: json_resources(Admin::ProductResource, products)
    end

    # Return product with slug
    # Return product with ID
    # GET /admin/products/?slug=:slug
    # GET /admin/products/:id
    def show
      render status: 200, json: json_resource(Admin::ProductResource, @product)
    end

    # Create a product
    # POST /admin/products
    def create
      product = Product.new(permitted_attributes)
      product.main_category_id = main_category
      product.sub_category_id = sub_category
      if product.save!
        render status: 201, json: json_resource(Admin::ProductResource, product)
      else
        render status: 422, json: json_errors(product)
      end
    end

    # Update a product
    # PUT /admin/products/:id
    def update
      @product.assign_attributes(permitted_attributes)
      @product.main_category_id = main_category
      @product.sub_category_id = sub_category
      if @product.save!
        render status: 204, json: json_resource(Admin::ProductResource, @product)
      else
        render status: 422, json: json_errors(@product)
      end
    end

    # Delete a product
    # DELETE /admin/products/:id
    def destroy
      @product.destroy
      head 204
    end

    private

    def find_product
      @product = Product.find_by_slug(params[:slug]) if params[:slug]
      @product = Product.find_by_id(params[:id]) if params[:id]
      return not_found if @product.nil? && (params[:id] || params[:slug])
    end

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

    def not_found
      json_error(422, 'product-not-found', 'No product with this ID / slug was found.')
    end
  end
end
