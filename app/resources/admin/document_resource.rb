# frozen_string_literal: true

module Admin
  class DocumentResource < JSONAPI::Resource
    attributes :name,
               :url,
               :public,
               :document_type
  end
end
