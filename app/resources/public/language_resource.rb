module Public
  class LanguageResource < JSONAPI::Resource
    attributes :locale,
               :name_english,
               :name_native
  end
end
