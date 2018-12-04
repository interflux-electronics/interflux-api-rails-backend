module V1
  module Public
    class ProductGroupSerializer < ApplicationSerializer
      include FastJsonapi::ObjectSerializer

      attributes :slug,
                 :name_single,
                 :name_plural

      belongs_to :parent_group, record_type: :product_group, serializer: :product_group
    end
  end
end
