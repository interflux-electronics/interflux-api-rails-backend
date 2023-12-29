module V1
  module Admin
    class ProductVideoSerializer < ApplicationSerializer
      attributes :rank,
                 :public

      belongs_to :product
      belongs_to :video
    end
  end
end
