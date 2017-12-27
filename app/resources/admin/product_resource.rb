module Admin
  class ProductResource < JSONAPI::Resource
    attributes :name,
               :slug,
               :public,
               :pitch,
               :body

    relationship :product_category, to: :one
  end
end
