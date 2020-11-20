module V1
  module Public
    class ProductUseSerializer < ApplicationSerializer
      belongs_to :product
      belongs_to :use
    end
  end
end
