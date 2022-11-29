module V1
  module Admin
    class DocumentSerializer < ApplicationSerializer
      attributes :path,
                 :name,
                 :variations,
                 :public

      belongs_to :document_category

      has_many :cdn_files, if: requested?('cdn_files')
      has_many :products, if: requested?('products')
      has_many :product_documents, if: requested?('product_documents')
    end
  end
end
