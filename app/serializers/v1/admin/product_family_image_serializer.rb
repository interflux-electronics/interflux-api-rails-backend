module V1
  module Admin
    class ProductFamilyImageSerializer < ApplicationSerializer
      belongs_to :product_family
      belongs_to :image
    end
  end
end
