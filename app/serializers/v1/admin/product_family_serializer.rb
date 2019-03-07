module V1
  module Admin
    class ProductFamilySerializer < ApplicationSerializer
      attributes :slug,
                 :code,
                 :name_single,
                 :name_plural,
                 :created_at,
                 :updated_at
    end
  end
end
