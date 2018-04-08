module Admin
  class ProductsController < Admin::AuthenticatedController
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
      Product
    end

    def serializer_klass
      Admin::ProductSerializer
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
      {
        main_category_id: permit_relationship('main-category')[:id],
        sub_category_id: permit_relationship('sub-category')[:id]
      }
    end

    def filters
      %i[]
    end

    def includes
      %i[]
    end
  end
end
