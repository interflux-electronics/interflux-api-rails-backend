module V1
  module Admin
    class ProductFamilyImageSerializer < ApplicationSerializer
      attributes :rank_among_families,
                 :rank_among_images

      belongs_to :product_family
      belongs_to :image
    end
  end
end
