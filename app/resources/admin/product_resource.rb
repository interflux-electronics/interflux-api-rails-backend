# frozen_string_literal: true

module Admin
  class ProductResource < JSONAPI::Resource
    attributes :name,
               :slug,
               :public,
               :pitch,
               :body

    relationship :product_group, to: :one
    relationship :product_sub_group, to: :one
  end
end
