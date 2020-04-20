module V1
  module Public
    class ProductSerializer < ApplicationSerializer
      attributes :slug,
                 :name,
                 :public

      belongs_to :product_family
      belongs_to :image

      has_many :documents, if: Proc.new { |record, params|
        params && params['include'] && params['include'].split(',').include?('documents')
      }

      has_many :images, if: Proc.new { |record, params|
        params && params['include'] && params['include'].split(',').include?('images')
      }

      has_many :features, if: Proc.new { |record, params|
        params && params['include'] && params['include'].split(',').include?('features')
      }
    end
  end
end
