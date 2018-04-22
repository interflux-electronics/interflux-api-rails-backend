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
      Admin::LanguageSerializer
    end

    def attributes
      %i[]
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



# module Admin
#   class LanguagesController < Admin::AuthenticatedController
#     # Return all languages
#     # GET /admin/languages
#     def index
#       languages = Language.all
#       json = Admin::LanguageSerializer.new(languages).serialized_json
#       render status: 200, json: json
#     end
#
#     # Return language by ID
#     # GET /admin/languages/:id
#     def show
#       language = Language.find_by_id(params[:id])
#       return ressource_not_found if language.nil?
#       json = Admin::LanguageSerializer.new(language).serialized_json
#       render status: 200, json: json
#     end
#   end
# end
