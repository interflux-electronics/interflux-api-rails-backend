module V1
  module Admin
    class ProductFeatureSerializer < ApplicationSerializer
      belongs_to :product
      belongs_to :feature
    end
  end
end
