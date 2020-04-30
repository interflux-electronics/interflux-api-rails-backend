module V1
  module Public
    class ProductFeatureSerializer < ApplicationSerializer
      belongs_to :product
      belongs_to :feature
    end
  end
end
