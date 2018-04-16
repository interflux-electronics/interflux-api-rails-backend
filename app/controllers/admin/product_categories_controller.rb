module Admin
  class ProductCategoriesController < Admin::AuthenticatedController
    # Admins can fetch all product categories
    def index
      super
    end

    # Admins can fetch a single product category
    def show
      super
    end

    # Only super admins create product categories from command line
    def create
      forbidden
    end

    # Only super admins edit product categories from command line
    def update
      forbidden
    end

    # Only super admins delete product categories from command line
    def destroy
      forbidden
    end

    private

    def resource_klass
      ProductCategory
    end

    def serializer_klass
      Admin::ProductCategorySerializer
    end

    def attributes
      %i[]
    end

    def relationships
      %i[]
    end

    def filters
      %i[]
    end

    def includes
      %i[]
    end
  end
end
