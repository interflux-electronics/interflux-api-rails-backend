module Admin
  class ImageSourcesController < Admin::AuthenticatedController
    # There are no user cases for fetching image sources.
    # Instead always include with product image.
    def index
      forbidden
    end

    def show
      forbidden
    end

    def create
      super
    end

    def update
      super
    end

    def destroy
      super
    end

    private

    def resource_klass
      ImageSource
    end

    def serializer_klass
      Admin::ImageSourceSerializer
    end

    def attributes
      %i[
        url
        width
        height
      ]
    end

    def relationships
      %i[
        product_image_id
      ]
    end

    def filters
      %i[]
    end

    def includes
      %i[]
    end
  end
end
