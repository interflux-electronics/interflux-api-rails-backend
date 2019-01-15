module V1
  module Public
    class LanguageSerializer < ApplicationSerializer
      include FastJsonapi::ObjectSerializer

      attributes :slug,
                 :name_english,
                 :name_native
    end
  end
end
