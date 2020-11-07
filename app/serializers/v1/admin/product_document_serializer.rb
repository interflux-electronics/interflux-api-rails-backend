module V1
  module Admin
    class ProductDocumentSerializer < ApplicationSerializer
      belongs_to :product
      belongs_to :document
    end
  end
end
