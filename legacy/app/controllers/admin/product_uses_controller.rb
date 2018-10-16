module Admin
  class ProductUsesController < ApplicationController
    include Authentication

    # Admins can fetch all product features
    def index
      super
    end

    # Admins can fetch a single product feature
    def show
      super
    end

    # Admins can create product features
    def create
      super
    end

    # Admins can update product features
    def update
      super
    end

    # Admins can remove product features
    def destroy
      super
    end

    private

    def resource_klass
      ProductUse
    end

    def serializer_klass
      ProductUseSerializer
    end

    def attributes
      %i[]
    end

    def relationships
      %i[
        product_id
        use_id
      ]
    end

    def filters
      %i[
        product_id
        use_id
      ]
    end

    def includes
      %i[
        feature
        product
      ]
    end
  end
end
