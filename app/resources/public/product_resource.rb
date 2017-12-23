module Public
  class ProductResource < JSONAPI::Resource
    attributes :name,
               :slug,
               :pitch,
               :body

    relationship :product_group, to: :one
    relationship :product_sub_group, to: :one
  end
end
