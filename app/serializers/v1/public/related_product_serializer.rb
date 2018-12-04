module V1
  module Public
    class RelatedProductSerializer < ApplicationSerializer
      include FastJsonapi::ObjectSerializer

      set_type :product

      attributes :slug,
                 :name,
                 :pitch

      belongs_to :main_group, record_type: :product_group, serializer: :product_group
      belongs_to :sub_group, record_type: :product_group, serializer: :product_group
    end
  end
end
