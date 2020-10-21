module V1
  module Admin
    class ProductFamilySerializer < ApplicationSerializer
      attributes :slug,
                 :name_single,
                 :name_plural,
                 :order

      has_many :products, if: Proc.new { |record, params|
        params && params['include'] && params['include'].split(',').include?('products')
      }
    end
  end
end
