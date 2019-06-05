module V1
  module Public
    class ProductProcessSerializer < ApplicationSerializer
      belongs_to :product_serie
      belongs_to :soldering_process
    end
  end
end
