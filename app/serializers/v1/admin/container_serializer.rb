module V1
  module Admin
    class ContainerSerializer < ApplicationSerializer
      attributes :name,
                 :code,
                 :created_at,
                 :updated_at

      has_many :product_variants
    end
  end
end
