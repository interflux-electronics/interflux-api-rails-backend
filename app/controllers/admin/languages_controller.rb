module Admin
  class LanguagesController < Admin::AuthenticatedController
    # Return all languages
    # GET /admin/languages
    def index
      languages = Language.all
      json = Admin::LanguageSerializer.new(languages).serialized_json
      render status: 200, json: json
    end

    # Return language by ID
    # GET /public/product-categories/:id
    def show
      language = Language.find(params[:id])
      return ressource_not_found if language.nil?
      json = Admin::LanguageSerializer.new(language).serialized_json
      render status: 200, json: json
    end
  end
end
