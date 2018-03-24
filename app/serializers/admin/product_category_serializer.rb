module Admin
  class ProductCategorySerializer < ApplicationSerializer
    attributes :slug,
               :name_plural,
               :name_single

    belongs_to :parent_category, record_type: :product_category
  end
end
