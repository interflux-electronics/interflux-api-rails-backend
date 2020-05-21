module V1
  module Public
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
    end
  end
end
