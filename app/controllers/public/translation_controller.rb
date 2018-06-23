module Public
  class TranslationsController < ApplicationController
    # Public users can fetch all translations
    def index
      locales = ['en', 'cs', 'de', 'es', 'fr', 'id', 'it', 'pl', 'pt', 'ro', 'ru', 'sv', 'th', 'tr', 'zh']
      locale = request.env['HTTP_ACCEPT_LANGUAGE']
      valid = locales.include? locale
      return not_acceptable unless valid
      json = {}
      Translation.all.each do |translation|
        json[translation.slug] = translation[locale]
      end
      render status: 200, json: json
    end

    # No public user should ever fetch individual translations
    def show
      forbidden
    end

    # No public user should ever be able to create translations
    def create
      forbidden
    end

    # No public user should ever be able to update translations
    def update
      forbidden
    end

    # No public user should ever be able to delete translations
    def destroy
      forbidden
    end

    private

    # def resource_klass
    #   Translation
    # end

    # def serializer_klass
    #   Public::TranslationSerializer
    # end

    # def attributes
    #   %i[
    #     slug
    #     english
    #     native
    #   ]
    # end
    #
    # def relationships
    #   %i[
    #     language_id
    #   ]
    # end
    #
    # def filters
    #   %i[
    #     language_id
    #   ]
    # end
    #
    # def includes
    #   %i[]
    # end
  end
end
