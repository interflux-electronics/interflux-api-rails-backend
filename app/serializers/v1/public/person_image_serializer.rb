module V1
  module Public
    class PersonImageSerializer < ApplicationSerializer
      belongs_to :product
      belongs_to :image
    end
  end
end
