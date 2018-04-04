module Admin
  class ImageSourcesController < Admin::BaseController
    def index
      forbidden
    end

    def show
      super
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

    def model_class
      ImageSource
    end

    def serializer_class
      Admin::ImageSourceSerializer
    end

    def attributes
      params
        .require(:data)
        .require(:attributes)
        .permit(
          :url,
          :width,
          :height
        )
        .merge(relationships)
    end

    def relationships
      {
        image_id: relationship('image')[:id]
      }
    end
  end
end
