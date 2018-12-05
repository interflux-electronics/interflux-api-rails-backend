module Admin
  class ProductsController < ApplicationController
    include Authentication

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

    def creatable_attributes
      %i[
        name
        slug
        public
        pitch
        body
      ]
    end

    def creatable_relationships
      %i[
        main_category_id
        sub_category_id
      ]
    end

    def permitted_filters
      %i[]
    end

    def permitted_includes
      %i[]
    end
  end
end
