module V1
  module Public
    class ProductDocumentSerializer < ApplicationSerializer
      attributes :rank_among_documents

      belongs_to :product
      belongs_to :document
    end
  end
end
