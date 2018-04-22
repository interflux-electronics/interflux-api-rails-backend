module Public
  class ProductsController < ApplicationController
    # Public users can fetch all products
    def index
      super
    end

    # Public users can fetch invdividual products
    def show
      super
    end

    # No public user should ever be able to create products
    def create
      forbidden
    end

    # No public user should ever be able to update products
    def update
      forbidden
    end

    # No public user should ever be able to delete products
    def destroy
      forbidden
    end

    private

    def resource_klass
      Product
    end

    def serializer_klass
      Public::ProductSerializer
    end

    def attributes
      %i[
        name
        slug
        public
        pitch
        body
      ]
    end

    def relationships
      %i[
        main_category_id
        sub_category_id
      ]
    end

    def filters
      %i[
        main_category_id
        sub_category_id
      ]
    end

    def includes
      %i[]
    end
  end
end
