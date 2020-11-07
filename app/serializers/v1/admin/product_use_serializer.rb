module V1
  module Admin
    class ProductUseSerializer < ApplicationSerializer
      belongs_to :product
      belongs_to :use
    end
  end
end
