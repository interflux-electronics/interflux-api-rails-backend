module V1
  module Admin
    class ProductSerializer < ApplicationSerializer
      attributes :name,
                 :label,
                 :pitch,
                 :public,
                 :orderable,
                 :featured,
                 :popular,
                 :new

      belongs_to :product_family
      belongs_to :image

      # belongs_to :image, if: Proc.new { |record, params|
      #   params && params['include'] && ( params['include'].split(',').include?('image') || params['include'].split(',').include?('products.image') )
      # }

      has_many :documents, if: proc { |_record, params|
        params && params['include'] && params['include'].split(',').include?('documents')
      }

      has_many :images, if: proc { |_record, params|
        params && params['include'] && (params['include'].split(',').include?('images'))
      }

      has_many :product_images, if: proc { |_record, params|
        params && params['include'] && (params['include'].split(',').include?('product_images'))
      }

      has_many :features, if: proc { |_record, params|
        params && params['include'] && (params['include'].split(',').include?('features') || params['include'].split(',').include?('products.features') )
      }
    end
  end
end
