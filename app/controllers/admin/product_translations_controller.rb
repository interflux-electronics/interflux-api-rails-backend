module Admin
  class ProductTranslationsController < Admin::AuthenticatedController
    def index
      # There is no user case for someone wanting to fetch ALL translations
      return forbidden unless params[:filter]
      # Inherit as usual, but requires a filter param.
      super
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

    def resource_klass
      ProductTranslation
    end

    def serializer_klass
      Admin::ProductTranslationSerializer
    end

    def attributes
      %i[
        pitch
        body
      ]
    end

    def relationships
      %i[
        product_id
        language_id
      ]
    end

    def filters
      %i[
        product_id
        language_id
      ]
    end

    def includes
      %i[]
    end
  end
end
