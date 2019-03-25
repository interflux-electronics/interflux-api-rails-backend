module V1
  module Admin
    class ProductVariantSerializer < ApplicationSerializer
      attributes :slug,
                 :code,
                 :name,
                 :public,
                 :continued,
                 :created_at,
                 :updated_at

      belongs_to :product_serie
      belongs_to :container
    end
  end
end
