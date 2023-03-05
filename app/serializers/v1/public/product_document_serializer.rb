module V1
  module Public
    class ProductDocumentSerializer < ApplicationSerializer
      attributes :rank_among_documents

      belongs_to :product
      belongs_to :document

      cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 1.day
    end
  end
end
