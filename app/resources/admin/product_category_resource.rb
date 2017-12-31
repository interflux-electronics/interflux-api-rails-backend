module Admin
  class ProductCategoryResource < JSONAPI::Resource
    attributes :slug,
               :name_plural,
               :name_single

    relationship :parent_category, class_name: 'ProductCategory', foreign_key: 'parent_category_id', to: :one
  end
end
