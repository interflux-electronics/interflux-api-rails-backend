module Admin
  class ProductTranslationsController < Admin::AuthenticatedController
    def index
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

    def belongs_to
      %i[
        product
        language
      ]
    end

    # def relationships
    #   {
    #     product_id: permit_relationship('product')['id'],
    #     language_id: permit_relationship('language')['id']
    #   }
    # end

    def filters
      %i[
        product-id
        language-id
      ]
    end

    def includes
      %i[]
    end
  end
end
