module V1
  module Admin
    class ProductSerializer < ApplicationSerializer
      attributes :slug,
                 :code,
                 :name,
                 :public,
                 :deprecated,
                 :created_at,
                 :updated_at

      belongs_to :product_family
    end
  end
end
