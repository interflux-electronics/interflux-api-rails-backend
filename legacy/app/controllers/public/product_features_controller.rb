module Public
  class ProductFeaturesController < ApplicationController

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
      forbidden
    end

    # Admins can update product features
    def update
      forbidden
    end

    # Admins can remove product features
    def destroy
      forbidden
    end

    private

    def resource_klass
      ProductFeature
    end

    def serializer_klass
      ProductFeatureSerializer
    end

    def creatable_attributes
      %i[]
    end

    def creatable_relationships
      %i[
        product_id
        feature_id
      ]
    end

    def permitted_filters
      %i[
        product_id
      ]
    end

    def permitted_includes
      %i[
        feature
      ]
    end
  end
end
