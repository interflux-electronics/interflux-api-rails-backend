module V1
  module Admin
    class ProductQualitySerializer < ApplicationSerializer
      belongs_to :product
      belongs_to :quality
    end
  end
end
