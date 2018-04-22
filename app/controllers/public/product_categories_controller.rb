module Public
  class ProductCategoriesController < ApplicationController
    # Public users can fetch all product categories
    def index
      super
    end

    # Public users can fetch invdividual product categories
    def show
      super
    end

    # No public user should ever create categories
    def create
      forbidden
    end

    # No public user should ever update categories
    def update
      forbidden
    end

    # No public user should ever delete categories
    def destroy
      forbidden
    end

    private

    def resource_klass
      ProductCategory
    end

    def serializer_klass
      Public::ProductCategorySerializer
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
