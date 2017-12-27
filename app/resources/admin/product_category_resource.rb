module Admin
  class ProductCategoryResource < JSONAPI::Resource
    attributes :slug,
               :name_plural,
               :name_single,
               :product_category_id
  end
end
