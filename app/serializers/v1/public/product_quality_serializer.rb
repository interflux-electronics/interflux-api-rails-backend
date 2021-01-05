module V1
  module Public
    class ProductQualitySerializer < ApplicationSerializer
      # attributes :rank

      belongs_to :product
      belongs_to :quality
    end
  end
end
