# frozen_string_literal: true

module Admin
  class LanguageResource < JSONAPI::Resource
    attributes :name,
               :name_english,
               :name_native
  end
end
