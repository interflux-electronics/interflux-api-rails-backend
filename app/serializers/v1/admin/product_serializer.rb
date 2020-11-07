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

      has_many :documents, if: requested?('documents')
      has_many :images, if: requested?('images')
      has_many :product_images, if: requested?('product_images')
      has_many :product_documents, if: requested?('product_documents')
      has_many :product_uses, if: requested?('product_uses')
      has_many :product_qualities, if: requested?('product_qualities')
    end
  end
end
