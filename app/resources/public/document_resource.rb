# frozen_string_literal: true

module Public
  class DocumentResource < JSONAPI::Resource
    attributes :name,
               :url,
               :public,
               :document_type
  end
end
