module V1
  module Admin
    class ProductFamilySerializer < ApplicationSerializer
      attributes :slug,
                 :name_plural,
                 :name_single,
                 :code,
                 :public,
                 :created_at,
                 :updated_at
    end
  end
end
