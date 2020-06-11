module V1
  module Admin
    class ProductFamilySerializer < ApplicationSerializer
      attributes :slug,
                 :name_single,
                 :name_plural,
                 :order
    end
  end
end
