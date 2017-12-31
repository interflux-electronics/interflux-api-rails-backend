module Admin
  class ProductsController < Admin::AuthenticatedController
    before_action :set_product, only: %i[show update destroy]

    # Return all products
    # GET /admin/products
    def index
      products = Product.all.order('name desc')
      render status: 200, json: json_resources(Admin::ProductResource, products)
    end

    # Return 1 product by ID
    # GET /admin/products/:id
    def show
      render status: 200, json: json_resource(Admin::ProductResource, @product)
    end

    # Create a product
    # POST /admin/products
    def create
      @product = Product.new(permitted_attributes)
      @product.main_category_id = main_category
      @product.sub_category_id = sub_category
      if @product.save!
        render status: 201, json: json_resource(Admin::ProductResource, @product)
      else
        render status: 422, json: json_errors(@product)
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

    def set_product
      @product = Product.find(params[:id])
      return not_found unless @product.present?
    end

    def permitted_attributes
      params.require(:data)
            .require(:attributes)
            .permit(
              :name,
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

    def not_unique
      json_error(
        status: 422,
        code: 'not-unique',
        detail: 'This product name is already in use, please choose another.'
      )
    end

    def not_found
      json_error(
        status: 422,
        code: 'not-found',
        detail: 'No product with this ID was found.'
      )
    end
  end
end
