module V1
  module Admin
    class FeatureSerializer < ApplicationSerializer
      attributes :slug,
                 :text,
                 :icon,
                 :gist,
                 :category,
                 :has_page

      has_many :products, if: Proc.new { |record, params|
        params && params['include'] && params['include'].split(',').include?('products')
      }

      has_many :product_features, if: Proc.new { |record, params|
        params && params['include'] && params['include'].split(',').include?('product_features')
      }
    end
  end
end
