module V1
  module Public
    class ProductImageSerializer < ApplicationSerializer
      attributes :rank,
                 :public

      belongs_to :product
      belongs_to :image
    end
  end
end
