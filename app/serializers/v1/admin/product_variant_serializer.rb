module V1
  module Admin
    class ProductVariantSerializer < ApplicationSerializer
      attributes :slug,
                 :code,
                 :name,
                 :public,
                 :deprecated,
                 :created_at,
                 :updated_at

      belongs_to :product
      belongs_to :container
    end
  end
end
