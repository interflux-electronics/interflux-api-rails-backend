module V1
  module Public
    class ProductDocumentSerializer < ApplicationSerializer
      belongs_to :product
      belongs_to :document
    end
  end
end
