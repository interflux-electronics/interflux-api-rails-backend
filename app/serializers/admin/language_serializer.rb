module Admin
  class LanguageSerializer < ApplicationSerializer
    attributes :locale,
               :name_english,
               :name_native
  end
end
