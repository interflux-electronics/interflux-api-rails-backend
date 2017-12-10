# frozen_string_literal: true

module Admin
  class LanguagesController < Admin::AuthenticatedController
    # GET /admin/languages
    def index
      @records = Language.all
      @resources = @records.map { |language| LanguageResource.new(language, nil) }
      render json: JSONAPI::ResourceSerializer.new(Admin::LanguageResource).serialize_to_hash(@resources)
    end
  end
end
