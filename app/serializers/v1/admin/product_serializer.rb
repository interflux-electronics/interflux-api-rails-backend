module V1
  module Admin
    class ProductSerializer < ApplicationSerializer
      attributes :slug,
                 :code,
                 :name,
                 :public,
                 :continued,
                 :created_at,
                 :updated_at

      belongs_to :family_type
      belongs_to :product_type
    end
  end
end
