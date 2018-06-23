module Admin
  class ImagesController < ApplicationController
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
      Image
    end

    def serializer_klass
      ImageSerializer
    end

    def attributes
      %i[
        url
        width
        height
      ]
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
