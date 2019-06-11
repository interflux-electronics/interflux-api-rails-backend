module V1
  module Public
    class ProductVariantSerializer < ApplicationSerializer
      attributes :code,
                 :name

      belongs_to :product
      belongs_to :container
    end
  end
end
