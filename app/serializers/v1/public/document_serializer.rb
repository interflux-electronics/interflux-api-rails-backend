module V1
  module Public
    class DocumentSerializer < ApplicationSerializer
      attributes :path,
                 :name,
                 :variations

      belongs_to :document_category

      has_many :products, if: requested?('products')
      has_many :product_documents, if: requested?('product_documents')
      has_many :cdn_files, if: requested?('cdn_files')

      cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 1.day
    end
  end
end
