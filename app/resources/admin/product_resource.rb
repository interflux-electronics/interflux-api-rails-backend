# frozen_string_literal: true

module Admin
  class ProductResource < JSONAPI::Resource
    attributes :name,
               :slug,
               :public,
               :product_type,
               :pitch,
               :corpus
  end
end
