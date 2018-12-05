module Admin
  class LanguagesController < ApplicationController
    include Authentication

    # Admins can fetch all languages
    def index
      super
    end

    # Admins can fetch a single language
    def show
      super
    end

    # Only super admins create langauges from command line
    def create
      forbidden
    end

    # Only super admins edit langauges from command line
    def update
      forbidden
    end

    # Only super admins delete langauges from command line
    def destroy
      forbidden
    end

    private

    def resource_klass
      Language
    end

    def serializer_klass
      LanguageSerializer
    end

    def creatable_attributes
      %i[]
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
