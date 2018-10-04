module Admin
  class ProductImagesController < ApplicationController
    include Authentication

    # Admins can fetch all images
    def index
      super
    end

    # Admins can fetch a single image
    def show
      super
    end

    # Admins can create images
    def create
      super
    end

    # Admins can update images
    def update
      super
    end

    # Admins can remove images
    def destroy
      super
    end

    private

    def resource_klass
      ProductImage
    end

    def serializer_klass
      ProductImageSerializer
    end

    def attributes
      %i[]
    end

    def relationships
      %i[
        product_id
        image_id
      ]
    end

    def filters
      %i[
        product_id
      ]
    end

    def includes
      %i[
        image
      ]
    end
  end
end
