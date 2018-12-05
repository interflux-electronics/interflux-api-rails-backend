module Admin
  class FeaturesController < ApplicationController
    include Authentication

    # Admins can fetch all features
    def index
      super
    end

    # Admins can fetch a single feature
    def show
      super
    end

    # Admins can create features
    def create
      super
    end

    # Admins can update features
    def update
      super
    end

    # Admins can remove features
    def destroy
      super
    end

    private

    def resource_klass
      Feature
    end

    def serializer_klass
      FeatureSerializer
    end

    def creatable_attributes
      %i[
        label
        icon
      ]
    end

    def creatable_relationships
      %i[]
    end

    def permitted_filters
      %i[]
    end

    def permitted_includes
      %i[]
    end
  end
end
