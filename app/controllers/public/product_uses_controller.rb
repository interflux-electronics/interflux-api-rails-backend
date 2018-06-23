module Public
  class ProductUsesController < ApplicationController
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
      ProductUse
    end

    def serializer_klass
      ProductUseSerializer
    end

    def attributes
      %i[
        slug
        name
      ]
    end

    def relationships
      %i[]
    end

    def filters
      %i[
        product_id
        use_id
      ]
    end

    def includes
      %i[
        product
        use
      ]
    end
  end
end
