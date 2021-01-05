module V1
  module Public
    class ProductUseSerializer < ApplicationSerializer
      # attributes :rank

      belongs_to :product
      belongs_to :use
    end
  end
end
